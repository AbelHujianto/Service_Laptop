# Service Request Routes
import os
from flask import Blueprint, jsonify, request
from helper.db_helper import get_connection
from helper.form_validation import get_form_data
service_endpoints = Blueprint('service_requests', __name__)
UPLOAD_FOLDER = "img"

@service_endpoints.route('/service_requests', methods=['GET'])
def get_service_requests():
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM service_laptop_service_requests")
    results = cursor.fetchall()
    cursor.close()
    return jsonify({"message": "OK", "datas": results}), 200

@service_endpoints.route('/service_requests', methods=['POST'])
def create_service_request():
    data = get_form_data(["laptop_id", "user_id", "service_status", "request_date", "completion_date", "issue_description", "admin_id"])
    connection = get_connection()
    cursor = connection.cursor()
    insert_query = "INSERT INTO service_laptop_service_requests (laptop_id, user_id, service_status, request_date, completion_date, issue_description, admin_id) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    cursor.execute(insert_query, (data["laptop_id"], data["user_id"], data["service_status"], data["request_date"], data["completion_date"], data["issue_description"], data["admin_id"]))
    connection.commit()
    cursor.close()
    return jsonify({"message": "Service request created"}), 201

@service_endpoints.route('/service_requests/<int:request_id>', methods=['PUT'])
def update_service_request(request_id):
    data = request.form
    connection = get_connection()
    cursor = connection.cursor()
    update_query = "UPDATE service_laptop_service_requests SET laptop_id=%s, user_id=%s, service_status=%s, request_date=%s, completion_date=%s, issue_description=%s, admin_id=%s WHERE request_id=%s"
    cursor.execute(update_query, (data["laptop_id"], data["user_id"], data["service_status"], data["request_date"], data["completion_date"], data["issue_description"], data["admin_id"], request_id))
    connection.commit()
    cursor.close()
    return jsonify({"message": "Service request updated"}), 200

@service_endpoints.route('/service_requests/<int:request_id>', methods=['DELETE'])
def delete_service_request(request_id):
    connection = get_connection()
    cursor = connection.cursor()
    delete_query = "DELETE FROM service_laptop_service_requests WHERE request_id=%s"
    cursor.execute(delete_query, (request_id,))
    connection.commit()
    cursor.close()
    return jsonify({"message": "Service request deleted"}), 200