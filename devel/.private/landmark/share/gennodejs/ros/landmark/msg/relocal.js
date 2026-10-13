// Auto-generated. Do not edit!

// (in-package landmark.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class relocal {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.count = null;
      this.time_start = null;
      this.time_end = null;
      this.odom_reset = null;
      this.visionPoseType = null;
      this.count_repeat = null;
      this.amclPose = null;
      this.initialPose = null;
      this.diff_xy = null;
      this.diff_rotate = null;
      this.amclPose_relocal = null;
      this.diff_xy_relocal = null;
      this.diff_rotate_relocal = null;
      this.relocal_result = null;
    }
    else {
      if (initObj.hasOwnProperty('count')) {
        this.count = initObj.count
      }
      else {
        this.count = 0;
      }
      if (initObj.hasOwnProperty('time_start')) {
        this.time_start = initObj.time_start
      }
      else {
        this.time_start = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('time_end')) {
        this.time_end = initObj.time_end
      }
      else {
        this.time_end = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('odom_reset')) {
        this.odom_reset = initObj.odom_reset
      }
      else {
        this.odom_reset = false;
      }
      if (initObj.hasOwnProperty('visionPoseType')) {
        this.visionPoseType = initObj.visionPoseType
      }
      else {
        this.visionPoseType = 0;
      }
      if (initObj.hasOwnProperty('count_repeat')) {
        this.count_repeat = initObj.count_repeat
      }
      else {
        this.count_repeat = 0;
      }
      if (initObj.hasOwnProperty('amclPose')) {
        this.amclPose = initObj.amclPose
      }
      else {
        this.amclPose = [];
      }
      if (initObj.hasOwnProperty('initialPose')) {
        this.initialPose = initObj.initialPose
      }
      else {
        this.initialPose = [];
      }
      if (initObj.hasOwnProperty('diff_xy')) {
        this.diff_xy = initObj.diff_xy
      }
      else {
        this.diff_xy = 0.0;
      }
      if (initObj.hasOwnProperty('diff_rotate')) {
        this.diff_rotate = initObj.diff_rotate
      }
      else {
        this.diff_rotate = 0.0;
      }
      if (initObj.hasOwnProperty('amclPose_relocal')) {
        this.amclPose_relocal = initObj.amclPose_relocal
      }
      else {
        this.amclPose_relocal = [];
      }
      if (initObj.hasOwnProperty('diff_xy_relocal')) {
        this.diff_xy_relocal = initObj.diff_xy_relocal
      }
      else {
        this.diff_xy_relocal = 0.0;
      }
      if (initObj.hasOwnProperty('diff_rotate_relocal')) {
        this.diff_rotate_relocal = initObj.diff_rotate_relocal
      }
      else {
        this.diff_rotate_relocal = 0.0;
      }
      if (initObj.hasOwnProperty('relocal_result')) {
        this.relocal_result = initObj.relocal_result
      }
      else {
        this.relocal_result = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type relocal
    // Serialize message field [count]
    bufferOffset = _serializer.int32(obj.count, buffer, bufferOffset);
    // Serialize message field [time_start]
    bufferOffset = _serializer.time(obj.time_start, buffer, bufferOffset);
    // Serialize message field [time_end]
    bufferOffset = _serializer.time(obj.time_end, buffer, bufferOffset);
    // Serialize message field [odom_reset]
    bufferOffset = _serializer.bool(obj.odom_reset, buffer, bufferOffset);
    // Serialize message field [visionPoseType]
    bufferOffset = _serializer.int8(obj.visionPoseType, buffer, bufferOffset);
    // Serialize message field [count_repeat]
    bufferOffset = _serializer.int8(obj.count_repeat, buffer, bufferOffset);
    // Serialize message field [amclPose]
    bufferOffset = _arraySerializer.float32(obj.amclPose, buffer, bufferOffset, null);
    // Serialize message field [initialPose]
    bufferOffset = _arraySerializer.float32(obj.initialPose, buffer, bufferOffset, null);
    // Serialize message field [diff_xy]
    bufferOffset = _serializer.float32(obj.diff_xy, buffer, bufferOffset);
    // Serialize message field [diff_rotate]
    bufferOffset = _serializer.float32(obj.diff_rotate, buffer, bufferOffset);
    // Serialize message field [amclPose_relocal]
    bufferOffset = _arraySerializer.float32(obj.amclPose_relocal, buffer, bufferOffset, null);
    // Serialize message field [diff_xy_relocal]
    bufferOffset = _serializer.float32(obj.diff_xy_relocal, buffer, bufferOffset);
    // Serialize message field [diff_rotate_relocal]
    bufferOffset = _serializer.float32(obj.diff_rotate_relocal, buffer, bufferOffset);
    // Serialize message field [relocal_result]
    bufferOffset = _serializer.bool(obj.relocal_result, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type relocal
    let len;
    let data = new relocal(null);
    // Deserialize message field [count]
    data.count = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [time_start]
    data.time_start = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [time_end]
    data.time_end = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [odom_reset]
    data.odom_reset = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [visionPoseType]
    data.visionPoseType = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [count_repeat]
    data.count_repeat = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [amclPose]
    data.amclPose = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [initialPose]
    data.initialPose = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [diff_xy]
    data.diff_xy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [diff_rotate]
    data.diff_rotate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [amclPose_relocal]
    data.amclPose_relocal = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [diff_xy_relocal]
    data.diff_xy_relocal = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [diff_rotate_relocal]
    data.diff_rotate_relocal = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [relocal_result]
    data.relocal_result = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.amclPose.length;
    length += 4 * object.initialPose.length;
    length += 4 * object.amclPose_relocal.length;
    return length + 52;
  }

  static datatype() {
    // Returns string type for a message object
    return 'landmark/relocal';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fa066a9c18b30ac702fc89437c3d0ea4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 count
    time time_start
    time time_end
    bool odom_reset
    int8 visionPoseType
    int8 count_repeat
    float32[] amclPose
    float32[] initialPose
    float32 diff_xy
    float32 diff_rotate
    float32[] amclPose_relocal
    float32 diff_xy_relocal
    float32 diff_rotate_relocal
    bool relocal_result
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new relocal(null);
    if (msg.count !== undefined) {
      resolved.count = msg.count;
    }
    else {
      resolved.count = 0
    }

    if (msg.time_start !== undefined) {
      resolved.time_start = msg.time_start;
    }
    else {
      resolved.time_start = {secs: 0, nsecs: 0}
    }

    if (msg.time_end !== undefined) {
      resolved.time_end = msg.time_end;
    }
    else {
      resolved.time_end = {secs: 0, nsecs: 0}
    }

    if (msg.odom_reset !== undefined) {
      resolved.odom_reset = msg.odom_reset;
    }
    else {
      resolved.odom_reset = false
    }

    if (msg.visionPoseType !== undefined) {
      resolved.visionPoseType = msg.visionPoseType;
    }
    else {
      resolved.visionPoseType = 0
    }

    if (msg.count_repeat !== undefined) {
      resolved.count_repeat = msg.count_repeat;
    }
    else {
      resolved.count_repeat = 0
    }

    if (msg.amclPose !== undefined) {
      resolved.amclPose = msg.amclPose;
    }
    else {
      resolved.amclPose = []
    }

    if (msg.initialPose !== undefined) {
      resolved.initialPose = msg.initialPose;
    }
    else {
      resolved.initialPose = []
    }

    if (msg.diff_xy !== undefined) {
      resolved.diff_xy = msg.diff_xy;
    }
    else {
      resolved.diff_xy = 0.0
    }

    if (msg.diff_rotate !== undefined) {
      resolved.diff_rotate = msg.diff_rotate;
    }
    else {
      resolved.diff_rotate = 0.0
    }

    if (msg.amclPose_relocal !== undefined) {
      resolved.amclPose_relocal = msg.amclPose_relocal;
    }
    else {
      resolved.amclPose_relocal = []
    }

    if (msg.diff_xy_relocal !== undefined) {
      resolved.diff_xy_relocal = msg.diff_xy_relocal;
    }
    else {
      resolved.diff_xy_relocal = 0.0
    }

    if (msg.diff_rotate_relocal !== undefined) {
      resolved.diff_rotate_relocal = msg.diff_rotate_relocal;
    }
    else {
      resolved.diff_rotate_relocal = 0.0
    }

    if (msg.relocal_result !== undefined) {
      resolved.relocal_result = msg.relocal_result;
    }
    else {
      resolved.relocal_result = false
    }

    return resolved;
    }
};

module.exports = relocal;
