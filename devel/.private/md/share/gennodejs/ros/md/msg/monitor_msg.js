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

class monitor_msg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lPosiX = null;
      this.lPosiY = null;
      this.sTheta = null;
      this.sRealLinearVel = null;
      this.sRealAngularVel = null;
      this.sVoltIn = null;
      this.sLeftMotCur = null;
      this.sRightMotCur = null;
      this.byUS1 = null;
      this.byUS2 = null;
      this.byUS3 = null;
      this.byUS4 = null;
      this.byPlatStatus = null;
      this.byDocStatus = null;
      this.byLeftMotStatus = null;
      this.byRightMotStatus = null;
      this.lLeftMotPosi = null;
      this.lRightMotPosi = null;
      this.byLeftIOMonitor = null;
      this.byRightIOMonitor = null;
    }
    else {
      if (initObj.hasOwnProperty('lPosiX')) {
        this.lPosiX = initObj.lPosiX
      }
      else {
        this.lPosiX = 0;
      }
      if (initObj.hasOwnProperty('lPosiY')) {
        this.lPosiY = initObj.lPosiY
      }
      else {
        this.lPosiY = 0;
      }
      if (initObj.hasOwnProperty('sTheta')) {
        this.sTheta = initObj.sTheta
      }
      else {
        this.sTheta = 0;
      }
      if (initObj.hasOwnProperty('sRealLinearVel')) {
        this.sRealLinearVel = initObj.sRealLinearVel
      }
      else {
        this.sRealLinearVel = 0;
      }
      if (initObj.hasOwnProperty('sRealAngularVel')) {
        this.sRealAngularVel = initObj.sRealAngularVel
      }
      else {
        this.sRealAngularVel = 0;
      }
      if (initObj.hasOwnProperty('sVoltIn')) {
        this.sVoltIn = initObj.sVoltIn
      }
      else {
        this.sVoltIn = 0;
      }
      if (initObj.hasOwnProperty('sLeftMotCur')) {
        this.sLeftMotCur = initObj.sLeftMotCur
      }
      else {
        this.sLeftMotCur = 0;
      }
      if (initObj.hasOwnProperty('sRightMotCur')) {
        this.sRightMotCur = initObj.sRightMotCur
      }
      else {
        this.sRightMotCur = 0;
      }
      if (initObj.hasOwnProperty('byUS1')) {
        this.byUS1 = initObj.byUS1
      }
      else {
        this.byUS1 = 0;
      }
      if (initObj.hasOwnProperty('byUS2')) {
        this.byUS2 = initObj.byUS2
      }
      else {
        this.byUS2 = 0;
      }
      if (initObj.hasOwnProperty('byUS3')) {
        this.byUS3 = initObj.byUS3
      }
      else {
        this.byUS3 = 0;
      }
      if (initObj.hasOwnProperty('byUS4')) {
        this.byUS4 = initObj.byUS4
      }
      else {
        this.byUS4 = 0;
      }
      if (initObj.hasOwnProperty('byPlatStatus')) {
        this.byPlatStatus = initObj.byPlatStatus
      }
      else {
        this.byPlatStatus = 0;
      }
      if (initObj.hasOwnProperty('byDocStatus')) {
        this.byDocStatus = initObj.byDocStatus
      }
      else {
        this.byDocStatus = 0;
      }
      if (initObj.hasOwnProperty('byLeftMotStatus')) {
        this.byLeftMotStatus = initObj.byLeftMotStatus
      }
      else {
        this.byLeftMotStatus = 0;
      }
      if (initObj.hasOwnProperty('byRightMotStatus')) {
        this.byRightMotStatus = initObj.byRightMotStatus
      }
      else {
        this.byRightMotStatus = 0;
      }
      if (initObj.hasOwnProperty('lLeftMotPosi')) {
        this.lLeftMotPosi = initObj.lLeftMotPosi
      }
      else {
        this.lLeftMotPosi = 0;
      }
      if (initObj.hasOwnProperty('lRightMotPosi')) {
        this.lRightMotPosi = initObj.lRightMotPosi
      }
      else {
        this.lRightMotPosi = 0;
      }
      if (initObj.hasOwnProperty('byLeftIOMonitor')) {
        this.byLeftIOMonitor = initObj.byLeftIOMonitor
      }
      else {
        this.byLeftIOMonitor = 0;
      }
      if (initObj.hasOwnProperty('byRightIOMonitor')) {
        this.byRightIOMonitor = initObj.byRightIOMonitor
      }
      else {
        this.byRightIOMonitor = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type monitor_msg
    // Serialize message field [lPosiX]
    bufferOffset = _serializer.int32(obj.lPosiX, buffer, bufferOffset);
    // Serialize message field [lPosiY]
    bufferOffset = _serializer.int32(obj.lPosiY, buffer, bufferOffset);
    // Serialize message field [sTheta]
    bufferOffset = _serializer.int16(obj.sTheta, buffer, bufferOffset);
    // Serialize message field [sRealLinearVel]
    bufferOffset = _serializer.int16(obj.sRealLinearVel, buffer, bufferOffset);
    // Serialize message field [sRealAngularVel]
    bufferOffset = _serializer.int16(obj.sRealAngularVel, buffer, bufferOffset);
    // Serialize message field [sVoltIn]
    bufferOffset = _serializer.int16(obj.sVoltIn, buffer, bufferOffset);
    // Serialize message field [sLeftMotCur]
    bufferOffset = _serializer.int16(obj.sLeftMotCur, buffer, bufferOffset);
    // Serialize message field [sRightMotCur]
    bufferOffset = _serializer.int16(obj.sRightMotCur, buffer, bufferOffset);
    // Serialize message field [byUS1]
    bufferOffset = _serializer.uint8(obj.byUS1, buffer, bufferOffset);
    // Serialize message field [byUS2]
    bufferOffset = _serializer.uint8(obj.byUS2, buffer, bufferOffset);
    // Serialize message field [byUS3]
    bufferOffset = _serializer.uint8(obj.byUS3, buffer, bufferOffset);
    // Serialize message field [byUS4]
    bufferOffset = _serializer.uint8(obj.byUS4, buffer, bufferOffset);
    // Serialize message field [byPlatStatus]
    bufferOffset = _serializer.uint8(obj.byPlatStatus, buffer, bufferOffset);
    // Serialize message field [byDocStatus]
    bufferOffset = _serializer.uint8(obj.byDocStatus, buffer, bufferOffset);
    // Serialize message field [byLeftMotStatus]
    bufferOffset = _serializer.uint8(obj.byLeftMotStatus, buffer, bufferOffset);
    // Serialize message field [byRightMotStatus]
    bufferOffset = _serializer.uint8(obj.byRightMotStatus, buffer, bufferOffset);
    // Serialize message field [lLeftMotPosi]
    bufferOffset = _serializer.int32(obj.lLeftMotPosi, buffer, bufferOffset);
    // Serialize message field [lRightMotPosi]
    bufferOffset = _serializer.int32(obj.lRightMotPosi, buffer, bufferOffset);
    // Serialize message field [byLeftIOMonitor]
    bufferOffset = _serializer.uint8(obj.byLeftIOMonitor, buffer, bufferOffset);
    // Serialize message field [byRightIOMonitor]
    bufferOffset = _serializer.uint8(obj.byRightIOMonitor, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type monitor_msg
    let len;
    let data = new monitor_msg(null);
    // Deserialize message field [lPosiX]
    data.lPosiX = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [lPosiY]
    data.lPosiY = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [sTheta]
    data.sTheta = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [sRealLinearVel]
    data.sRealLinearVel = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [sRealAngularVel]
    data.sRealAngularVel = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [sVoltIn]
    data.sVoltIn = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [sLeftMotCur]
    data.sLeftMotCur = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [sRightMotCur]
    data.sRightMotCur = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [byUS1]
    data.byUS1 = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [byUS2]
    data.byUS2 = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [byUS3]
    data.byUS3 = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [byUS4]
    data.byUS4 = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [byPlatStatus]
    data.byPlatStatus = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [byDocStatus]
    data.byDocStatus = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [byLeftMotStatus]
    data.byLeftMotStatus = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [byRightMotStatus]
    data.byRightMotStatus = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [lLeftMotPosi]
    data.lLeftMotPosi = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [lRightMotPosi]
    data.lRightMotPosi = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [byLeftIOMonitor]
    data.byLeftIOMonitor = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [byRightIOMonitor]
    data.byRightIOMonitor = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 38;
  }

  static datatype() {
    // Returns string type for a message object
    return 'md/monitor_msg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '265bab62db87a50551604683361197df';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 lPosiX 
    int32 lPosiY
    int16 sTheta
    int16 sRealLinearVel
    int16 sRealAngularVel
    int16 sVoltIn
    int16 sLeftMotCur
    int16 sRightMotCur
    uint8 byUS1
    uint8 byUS2
    uint8 byUS3
    uint8 byUS4
    uint8 byPlatStatus
    uint8 byDocStatus
    uint8 byLeftMotStatus
    uint8 byRightMotStatus
    int32 lLeftMotPosi
    int32 lRightMotPosi
    uint8 byLeftIOMonitor
    uint8 byRightIOMonitor
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new monitor_msg(null);
    if (msg.lPosiX !== undefined) {
      resolved.lPosiX = msg.lPosiX;
    }
    else {
      resolved.lPosiX = 0
    }

    if (msg.lPosiY !== undefined) {
      resolved.lPosiY = msg.lPosiY;
    }
    else {
      resolved.lPosiY = 0
    }

    if (msg.sTheta !== undefined) {
      resolved.sTheta = msg.sTheta;
    }
    else {
      resolved.sTheta = 0
    }

    if (msg.sRealLinearVel !== undefined) {
      resolved.sRealLinearVel = msg.sRealLinearVel;
    }
    else {
      resolved.sRealLinearVel = 0
    }

    if (msg.sRealAngularVel !== undefined) {
      resolved.sRealAngularVel = msg.sRealAngularVel;
    }
    else {
      resolved.sRealAngularVel = 0
    }

    if (msg.sVoltIn !== undefined) {
      resolved.sVoltIn = msg.sVoltIn;
    }
    else {
      resolved.sVoltIn = 0
    }

    if (msg.sLeftMotCur !== undefined) {
      resolved.sLeftMotCur = msg.sLeftMotCur;
    }
    else {
      resolved.sLeftMotCur = 0
    }

    if (msg.sRightMotCur !== undefined) {
      resolved.sRightMotCur = msg.sRightMotCur;
    }
    else {
      resolved.sRightMotCur = 0
    }

    if (msg.byUS1 !== undefined) {
      resolved.byUS1 = msg.byUS1;
    }
    else {
      resolved.byUS1 = 0
    }

    if (msg.byUS2 !== undefined) {
      resolved.byUS2 = msg.byUS2;
    }
    else {
      resolved.byUS2 = 0
    }

    if (msg.byUS3 !== undefined) {
      resolved.byUS3 = msg.byUS3;
    }
    else {
      resolved.byUS3 = 0
    }

    if (msg.byUS4 !== undefined) {
      resolved.byUS4 = msg.byUS4;
    }
    else {
      resolved.byUS4 = 0
    }

    if (msg.byPlatStatus !== undefined) {
      resolved.byPlatStatus = msg.byPlatStatus;
    }
    else {
      resolved.byPlatStatus = 0
    }

    if (msg.byDocStatus !== undefined) {
      resolved.byDocStatus = msg.byDocStatus;
    }
    else {
      resolved.byDocStatus = 0
    }

    if (msg.byLeftMotStatus !== undefined) {
      resolved.byLeftMotStatus = msg.byLeftMotStatus;
    }
    else {
      resolved.byLeftMotStatus = 0
    }

    if (msg.byRightMotStatus !== undefined) {
      resolved.byRightMotStatus = msg.byRightMotStatus;
    }
    else {
      resolved.byRightMotStatus = 0
    }

    if (msg.lLeftMotPosi !== undefined) {
      resolved.lLeftMotPosi = msg.lLeftMotPosi;
    }
    else {
      resolved.lLeftMotPosi = 0
    }

    if (msg.lRightMotPosi !== undefined) {
      resolved.lRightMotPosi = msg.lRightMotPosi;
    }
    else {
      resolved.lRightMotPosi = 0
    }

    if (msg.byLeftIOMonitor !== undefined) {
      resolved.byLeftIOMonitor = msg.byLeftIOMonitor;
    }
    else {
      resolved.byLeftIOMonitor = 0
    }

    if (msg.byRightIOMonitor !== undefined) {
      resolved.byRightIOMonitor = msg.byRightIOMonitor;
    }
    else {
      resolved.byRightIOMonitor = 0
    }

    return resolved;
    }
};

module.exports = monitor_msg;
