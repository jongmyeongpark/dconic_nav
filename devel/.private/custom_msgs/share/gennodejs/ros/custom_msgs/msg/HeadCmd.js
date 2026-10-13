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

class HeadCmd {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.base_tilt = null;
      this.tilt = null;
      this.pan = null;
      this.base_tilt_speed_rate = null;
      this.tilt_speed_rate = null;
      this.pan_speed_rate = null;
    }
    else {
      if (initObj.hasOwnProperty('base_tilt')) {
        this.base_tilt = initObj.base_tilt
      }
      else {
        this.base_tilt = 0.0;
      }
      if (initObj.hasOwnProperty('tilt')) {
        this.tilt = initObj.tilt
      }
      else {
        this.tilt = 0.0;
      }
      if (initObj.hasOwnProperty('pan')) {
        this.pan = initObj.pan
      }
      else {
        this.pan = 0.0;
      }
      if (initObj.hasOwnProperty('base_tilt_speed_rate')) {
        this.base_tilt_speed_rate = initObj.base_tilt_speed_rate
      }
      else {
        this.base_tilt_speed_rate = 0.0;
      }
      if (initObj.hasOwnProperty('tilt_speed_rate')) {
        this.tilt_speed_rate = initObj.tilt_speed_rate
      }
      else {
        this.tilt_speed_rate = 0.0;
      }
      if (initObj.hasOwnProperty('pan_speed_rate')) {
        this.pan_speed_rate = initObj.pan_speed_rate
      }
      else {
        this.pan_speed_rate = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HeadCmd
    // Serialize message field [base_tilt]
    bufferOffset = _serializer.float32(obj.base_tilt, buffer, bufferOffset);
    // Serialize message field [tilt]
    bufferOffset = _serializer.float32(obj.tilt, buffer, bufferOffset);
    // Serialize message field [pan]
    bufferOffset = _serializer.float32(obj.pan, buffer, bufferOffset);
    // Serialize message field [base_tilt_speed_rate]
    bufferOffset = _serializer.float32(obj.base_tilt_speed_rate, buffer, bufferOffset);
    // Serialize message field [tilt_speed_rate]
    bufferOffset = _serializer.float32(obj.tilt_speed_rate, buffer, bufferOffset);
    // Serialize message field [pan_speed_rate]
    bufferOffset = _serializer.float32(obj.pan_speed_rate, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HeadCmd
    let len;
    let data = new HeadCmd(null);
    // Deserialize message field [base_tilt]
    data.base_tilt = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tilt]
    data.tilt = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pan]
    data.pan = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [base_tilt_speed_rate]
    data.base_tilt_speed_rate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [tilt_speed_rate]
    data.tilt_speed_rate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pan_speed_rate]
    data.pan_speed_rate = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msgs/HeadCmd';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '367b243a2924fb2bb03e2f8e186db888';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 base_tilt
    float32 tilt
    float32 pan
    
    float32 base_tilt_speed_rate
    float32 tilt_speed_rate
    float32 pan_speed_rate
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HeadCmd(null);
    if (msg.base_tilt !== undefined) {
      resolved.base_tilt = msg.base_tilt;
    }
    else {
      resolved.base_tilt = 0.0
    }

    if (msg.tilt !== undefined) {
      resolved.tilt = msg.tilt;
    }
    else {
      resolved.tilt = 0.0
    }

    if (msg.pan !== undefined) {
      resolved.pan = msg.pan;
    }
    else {
      resolved.pan = 0.0
    }

    if (msg.base_tilt_speed_rate !== undefined) {
      resolved.base_tilt_speed_rate = msg.base_tilt_speed_rate;
    }
    else {
      resolved.base_tilt_speed_rate = 0.0
    }

    if (msg.tilt_speed_rate !== undefined) {
      resolved.tilt_speed_rate = msg.tilt_speed_rate;
    }
    else {
      resolved.tilt_speed_rate = 0.0
    }

    if (msg.pan_speed_rate !== undefined) {
      resolved.pan_speed_rate = msg.pan_speed_rate;
    }
    else {
      resolved.pan_speed_rate = 0.0
    }

    return resolved;
    }
};

module.exports = HeadCmd;
