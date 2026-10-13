// Auto-generated. Do not edit!

// (in-package node_alive.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class ListNodesAliveRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ListNodesAliveRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ListNodesAliveRequest
    let len;
    let data = new ListNodesAliveRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'node_alive/ListNodesAliveRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ListNodesAliveRequest(null);
    return resolved;
    }
};

class ListNodesAliveResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.tracked_nodes = null;
      this.seen_nodes = null;
      this.alive_nodes = null;
      this.listed_nodes = null;
    }
    else {
      if (initObj.hasOwnProperty('tracked_nodes')) {
        this.tracked_nodes = initObj.tracked_nodes
      }
      else {
        this.tracked_nodes = 0;
      }
      if (initObj.hasOwnProperty('seen_nodes')) {
        this.seen_nodes = initObj.seen_nodes
      }
      else {
        this.seen_nodes = 0;
      }
      if (initObj.hasOwnProperty('alive_nodes')) {
        this.alive_nodes = initObj.alive_nodes
      }
      else {
        this.alive_nodes = 0;
      }
      if (initObj.hasOwnProperty('listed_nodes')) {
        this.listed_nodes = initObj.listed_nodes
      }
      else {
        this.listed_nodes = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ListNodesAliveResponse
    // Serialize message field [tracked_nodes]
    bufferOffset = _serializer.uint32(obj.tracked_nodes, buffer, bufferOffset);
    // Serialize message field [seen_nodes]
    bufferOffset = _serializer.uint32(obj.seen_nodes, buffer, bufferOffset);
    // Serialize message field [alive_nodes]
    bufferOffset = _serializer.uint32(obj.alive_nodes, buffer, bufferOffset);
    // Serialize message field [listed_nodes]
    bufferOffset = _serializer.uint32(obj.listed_nodes, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ListNodesAliveResponse
    let len;
    let data = new ListNodesAliveResponse(null);
    // Deserialize message field [tracked_nodes]
    data.tracked_nodes = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [seen_nodes]
    data.seen_nodes = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [alive_nodes]
    data.alive_nodes = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [listed_nodes]
    data.listed_nodes = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'node_alive/ListNodesAliveResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '206cbe3e6af816a2d654986b53d52287';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 tracked_nodes
    uint32 seen_nodes
    uint32 alive_nodes
    uint32 listed_nodes
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ListNodesAliveResponse(null);
    if (msg.tracked_nodes !== undefined) {
      resolved.tracked_nodes = msg.tracked_nodes;
    }
    else {
      resolved.tracked_nodes = 0
    }

    if (msg.seen_nodes !== undefined) {
      resolved.seen_nodes = msg.seen_nodes;
    }
    else {
      resolved.seen_nodes = 0
    }

    if (msg.alive_nodes !== undefined) {
      resolved.alive_nodes = msg.alive_nodes;
    }
    else {
      resolved.alive_nodes = 0
    }

    if (msg.listed_nodes !== undefined) {
      resolved.listed_nodes = msg.listed_nodes;
    }
    else {
      resolved.listed_nodes = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: ListNodesAliveRequest,
  Response: ListNodesAliveResponse,
  md5sum() { return '206cbe3e6af816a2d654986b53d52287'; },
  datatype() { return 'node_alive/ListNodesAlive'; }
};
