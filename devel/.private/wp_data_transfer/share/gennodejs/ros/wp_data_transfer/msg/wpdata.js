// Auto-generated. Do not edit!

// (in-package wp_data_transfer.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class wpdata {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.filename = null;
      this.wp_quan = null;
      this.x = null;
      this.y = null;
      this.z = null;
      this.qx = null;
      this.qy = null;
      this.qz = null;
      this.qw = null;
    }
    else {
      if (initObj.hasOwnProperty('filename')) {
        this.filename = initObj.filename
      }
      else {
        this.filename = '';
      }
      if (initObj.hasOwnProperty('wp_quan')) {
        this.wp_quan = initObj.wp_quan
      }
      else {
        this.wp_quan = 0;
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = [];
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = [];
      }
      if (initObj.hasOwnProperty('z')) {
        this.z = initObj.z
      }
      else {
        this.z = [];
      }
      if (initObj.hasOwnProperty('qx')) {
        this.qx = initObj.qx
      }
      else {
        this.qx = [];
      }
      if (initObj.hasOwnProperty('qy')) {
        this.qy = initObj.qy
      }
      else {
        this.qy = [];
      }
      if (initObj.hasOwnProperty('qz')) {
        this.qz = initObj.qz
      }
      else {
        this.qz = [];
      }
      if (initObj.hasOwnProperty('qw')) {
        this.qw = initObj.qw
      }
      else {
        this.qw = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type wpdata
    // Serialize message field [filename]
    bufferOffset = _serializer.string(obj.filename, buffer, bufferOffset);
    // Serialize message field [wp_quan]
    bufferOffset = _serializer.int32(obj.wp_quan, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _arraySerializer.float32(obj.x, buffer, bufferOffset, null);
    // Serialize message field [y]
    bufferOffset = _arraySerializer.float32(obj.y, buffer, bufferOffset, null);
    // Serialize message field [z]
    bufferOffset = _arraySerializer.float32(obj.z, buffer, bufferOffset, null);
    // Serialize message field [qx]
    bufferOffset = _arraySerializer.float32(obj.qx, buffer, bufferOffset, null);
    // Serialize message field [qy]
    bufferOffset = _arraySerializer.float32(obj.qy, buffer, bufferOffset, null);
    // Serialize message field [qz]
    bufferOffset = _arraySerializer.float32(obj.qz, buffer, bufferOffset, null);
    // Serialize message field [qw]
    bufferOffset = _arraySerializer.float32(obj.qw, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type wpdata
    let len;
    let data = new wpdata(null);
    // Deserialize message field [filename]
    data.filename = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [wp_quan]
    data.wp_quan = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [y]
    data.y = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [z]
    data.z = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [qx]
    data.qx = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [qy]
    data.qy = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [qz]
    data.qz = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [qw]
    data.qw = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.filename);
    length += 4 * object.x.length;
    length += 4 * object.y.length;
    length += 4 * object.z.length;
    length += 4 * object.qx.length;
    length += 4 * object.qy.length;
    length += 4 * object.qz.length;
    length += 4 * object.qw.length;
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'wp_data_transfer/wpdata';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b7f4186776812b445625de94a6c120a9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string filename
    int32 wp_quan
    float32[] x
    float32[] y
    float32[] z
    float32[] qx
    float32[] qy
    float32[] qz
    float32[] qw
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new wpdata(null);
    if (msg.filename !== undefined) {
      resolved.filename = msg.filename;
    }
    else {
      resolved.filename = ''
    }

    if (msg.wp_quan !== undefined) {
      resolved.wp_quan = msg.wp_quan;
    }
    else {
      resolved.wp_quan = 0
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = []
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = []
    }

    if (msg.z !== undefined) {
      resolved.z = msg.z;
    }
    else {
      resolved.z = []
    }

    if (msg.qx !== undefined) {
      resolved.qx = msg.qx;
    }
    else {
      resolved.qx = []
    }

    if (msg.qy !== undefined) {
      resolved.qy = msg.qy;
    }
    else {
      resolved.qy = []
    }

    if (msg.qz !== undefined) {
      resolved.qz = msg.qz;
    }
    else {
      resolved.qz = []
    }

    if (msg.qw !== undefined) {
      resolved.qw = msg.qw;
    }
    else {
      resolved.qw = []
    }

    return resolved;
    }
};

module.exports = wpdata;
