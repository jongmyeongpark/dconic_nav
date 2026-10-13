// Auto-generated. Do not edit!

// (in-package md.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class vel_msg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.nLinear = null;
      this.nAngular = null;
      this.byResetOdometry = null;
      this.byResetAngle = null;
      this.byResetAlarm = null;
    }
    else {
      if (initObj.hasOwnProperty('nLinear')) {
        this.nLinear = initObj.nLinear
      }
      else {
        this.nLinear = 0;
      }
      if (initObj.hasOwnProperty('nAngular')) {
        this.nAngular = initObj.nAngular
      }
      else {
        this.nAngular = 0;
      }
      if (initObj.hasOwnProperty('byResetOdometry')) {
        this.byResetOdometry = initObj.byResetOdometry
      }
      else {
        this.byResetOdometry = 0;
      }
      if (initObj.hasOwnProperty('byResetAngle')) {
        this.byResetAngle = initObj.byResetAngle
      }
      else {
        this.byResetAngle = 0;
      }
      if (initObj.hasOwnProperty('byResetAlarm')) {
        this.byResetAlarm = initObj.byResetAlarm
      }
      else {
        this.byResetAlarm = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type vel_msg
    // Serialize message field [nLinear]
    bufferOffset = _serializer.int32(obj.nLinear, buffer, bufferOffset);
    // Serialize message field [nAngular]
    bufferOffset = _serializer.int32(obj.nAngular, buffer, bufferOffset);
    // Serialize message field [byResetOdometry]
    bufferOffset = _serializer.int8(obj.byResetOdometry, buffer, bufferOffset);
    // Serialize message field [byResetAngle]
    bufferOffset = _serializer.int8(obj.byResetAngle, buffer, bufferOffset);
    // Serialize message field [byResetAlarm]
    bufferOffset = _serializer.int8(obj.byResetAlarm, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type vel_msg
    let len;
    let data = new vel_msg(null);
    // Deserialize message field [nLinear]
    data.nLinear = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [nAngular]
    data.nAngular = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [byResetOdometry]
    data.byResetOdometry = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [byResetAngle]
    data.byResetAngle = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [byResetAlarm]
    data.byResetAlarm = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 11;
  }

  static datatype() {
    // Returns string type for a message object
    return 'md/vel_msg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e52979e2ff6a0ff38b6f29b2d215648d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 nLinear
    int32 nAngular
    int8 byResetOdometry
    int8 byResetAngle
    int8 byResetAlarm
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new vel_msg(null);
    if (msg.nLinear !== undefined) {
      resolved.nLinear = msg.nLinear;
    }
    else {
      resolved.nLinear = 0
    }

    if (msg.nAngular !== undefined) {
      resolved.nAngular = msg.nAngular;
    }
    else {
      resolved.nAngular = 0
    }

    if (msg.byResetOdometry !== undefined) {
      resolved.byResetOdometry = msg.byResetOdometry;
    }
    else {
      resolved.byResetOdometry = 0
    }

    if (msg.byResetAngle !== undefined) {
      resolved.byResetAngle = msg.byResetAngle;
    }
    else {
      resolved.byResetAngle = 0
    }

    if (msg.byResetAlarm !== undefined) {
      resolved.byResetAlarm = msg.byResetAlarm;
    }
    else {
      resolved.byResetAlarm = 0
    }

    return resolved;
    }
};

module.exports = vel_msg;
