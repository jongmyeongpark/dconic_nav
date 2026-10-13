// Auto-generated. Do not edit!

// (in-package custom_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Info {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.up_time = null;
      this.total_processes = null;
      this.running_processes = null;
      this.mem_usage = null;
      this.free_mem_gb = null;
      this.total_mem_gb = null;
      this.cpu_usage = null;
    }
    else {
      if (initObj.hasOwnProperty('up_time')) {
        this.up_time = initObj.up_time
      }
      else {
        this.up_time = '';
      }
      if (initObj.hasOwnProperty('total_processes')) {
        this.total_processes = initObj.total_processes
      }
      else {
        this.total_processes = 0;
      }
      if (initObj.hasOwnProperty('running_processes')) {
        this.running_processes = initObj.running_processes
      }
      else {
        this.running_processes = 0;
      }
      if (initObj.hasOwnProperty('mem_usage')) {
        this.mem_usage = initObj.mem_usage
      }
      else {
        this.mem_usage = 0.0;
      }
      if (initObj.hasOwnProperty('free_mem_gb')) {
        this.free_mem_gb = initObj.free_mem_gb
      }
      else {
        this.free_mem_gb = 0.0;
      }
      if (initObj.hasOwnProperty('total_mem_gb')) {
        this.total_mem_gb = initObj.total_mem_gb
      }
      else {
        this.total_mem_gb = 0.0;
      }
      if (initObj.hasOwnProperty('cpu_usage')) {
        this.cpu_usage = initObj.cpu_usage
      }
      else {
        this.cpu_usage = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Info
    // Serialize message field [up_time]
    bufferOffset = _serializer.string(obj.up_time, buffer, bufferOffset);
    // Serialize message field [total_processes]
    bufferOffset = _serializer.int32(obj.total_processes, buffer, bufferOffset);
    // Serialize message field [running_processes]
    bufferOffset = _serializer.int32(obj.running_processes, buffer, bufferOffset);
    // Serialize message field [mem_usage]
    bufferOffset = _serializer.float32(obj.mem_usage, buffer, bufferOffset);
    // Serialize message field [free_mem_gb]
    bufferOffset = _serializer.float32(obj.free_mem_gb, buffer, bufferOffset);
    // Serialize message field [total_mem_gb]
    bufferOffset = _serializer.float32(obj.total_mem_gb, buffer, bufferOffset);
    // Serialize message field [cpu_usage]
    bufferOffset = _serializer.float32(obj.cpu_usage, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Info
    let len;
    let data = new Info(null);
    // Deserialize message field [up_time]
    data.up_time = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [total_processes]
    data.total_processes = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [running_processes]
    data.running_processes = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [mem_usage]
    data.mem_usage = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [free_mem_gb]
    data.free_mem_gb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [total_mem_gb]
    data.total_mem_gb = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cpu_usage]
    data.cpu_usage = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.up_time);
    return length + 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msgs/Info';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '738f3ea40c97c1008ce1dfe197260832';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string up_time
    int32 total_processes
    int32 running_processes
    float32 mem_usage
    float32 free_mem_gb
    float32 total_mem_gb
    float32 cpu_usage
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Info(null);
    if (msg.up_time !== undefined) {
      resolved.up_time = msg.up_time;
    }
    else {
      resolved.up_time = ''
    }

    if (msg.total_processes !== undefined) {
      resolved.total_processes = msg.total_processes;
    }
    else {
      resolved.total_processes = 0
    }

    if (msg.running_processes !== undefined) {
      resolved.running_processes = msg.running_processes;
    }
    else {
      resolved.running_processes = 0
    }

    if (msg.mem_usage !== undefined) {
      resolved.mem_usage = msg.mem_usage;
    }
    else {
      resolved.mem_usage = 0.0
    }

    if (msg.free_mem_gb !== undefined) {
      resolved.free_mem_gb = msg.free_mem_gb;
    }
    else {
      resolved.free_mem_gb = 0.0
    }

    if (msg.total_mem_gb !== undefined) {
      resolved.total_mem_gb = msg.total_mem_gb;
    }
    else {
      resolved.total_mem_gb = 0.0
    }

    if (msg.cpu_usage !== undefined) {
      resolved.cpu_usage = msg.cpu_usage;
    }
    else {
      resolved.cpu_usage = 0.0
    }

    return resolved;
    }
};

module.exports = Info;
