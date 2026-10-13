// Auto-generated. Do not edit!

// (in-package custom_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Dependency = require('./Dependency.js');

//-----------------------------------------------------------

class Service {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.running = null;
      this.dependencies = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('running')) {
        this.running = initObj.running
      }
      else {
        this.running = false;
      }
      if (initObj.hasOwnProperty('dependencies')) {
        this.dependencies = initObj.dependencies
      }
      else {
        this.dependencies = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Service
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [running]
    bufferOffset = _serializer.bool(obj.running, buffer, bufferOffset);
    // Serialize message field [dependencies]
    // Serialize the length for message field [dependencies]
    bufferOffset = _serializer.uint32(obj.dependencies.length, buffer, bufferOffset);
    obj.dependencies.forEach((val) => {
      bufferOffset = Dependency.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Service
    let len;
    let data = new Service(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [running]
    data.running = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [dependencies]
    // Deserialize array length for message field [dependencies]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.dependencies = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.dependencies[i] = Dependency.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.name);
    object.dependencies.forEach((val) => {
      length += Dependency.getMessageSize(val);
    });
    return length + 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msgs/Service';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '38e06d554a566cfc75320c104827e776';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string name
    bool running
    custom_msgs/Dependency[] dependencies
    ================================================================================
    MSG: custom_msgs/Dependency
    string name
    bool is_service
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Service(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.running !== undefined) {
      resolved.running = msg.running;
    }
    else {
      resolved.running = false
    }

    if (msg.dependencies !== undefined) {
      resolved.dependencies = new Array(msg.dependencies.length);
      for (let i = 0; i < resolved.dependencies.length; ++i) {
        resolved.dependencies[i] = Dependency.Resolve(msg.dependencies[i]);
      }
    }
    else {
      resolved.dependencies = []
    }

    return resolved;
    }
};

module.exports = Service;
