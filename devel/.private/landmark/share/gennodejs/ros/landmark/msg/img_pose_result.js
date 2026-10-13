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

class img_pose_result {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.stamp = null;
      this.sim_id = null;
      this.score = null;
      this.amclPose = null;
      this.visionPose = null;
      this.diff_xy = null;
      this.diff_rotate = null;
      this.valid_status = null;
      this.mismatch_status = null;
      this.unjudge_status = null;
      this.relocal_status = null;
    }
    else {
      if (initObj.hasOwnProperty('stamp')) {
        this.stamp = initObj.stamp
      }
      else {
        this.stamp = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('sim_id')) {
        this.sim_id = initObj.sim_id
      }
      else {
        this.sim_id = 0;
      }
      if (initObj.hasOwnProperty('score')) {
        this.score = initObj.score
      }
      else {
        this.score = 0.0;
      }
      if (initObj.hasOwnProperty('amclPose')) {
        this.amclPose = initObj.amclPose
      }
      else {
        this.amclPose = [];
      }
      if (initObj.hasOwnProperty('visionPose')) {
        this.visionPose = initObj.visionPose
      }
      else {
        this.visionPose = [];
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
      if (initObj.hasOwnProperty('valid_status')) {
        this.valid_status = initObj.valid_status
      }
      else {
        this.valid_status = false;
      }
      if (initObj.hasOwnProperty('mismatch_status')) {
        this.mismatch_status = initObj.mismatch_status
      }
      else {
        this.mismatch_status = false;
      }
      if (initObj.hasOwnProperty('unjudge_status')) {
        this.unjudge_status = initObj.unjudge_status
      }
      else {
        this.unjudge_status = false;
      }
      if (initObj.hasOwnProperty('relocal_status')) {
        this.relocal_status = initObj.relocal_status
      }
      else {
        this.relocal_status = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type img_pose_result
    // Serialize message field [stamp]
    bufferOffset = _serializer.time(obj.stamp, buffer, bufferOffset);
    // Serialize message field [sim_id]
    bufferOffset = _serializer.int32(obj.sim_id, buffer, bufferOffset);
    // Serialize message field [score]
    bufferOffset = _serializer.float32(obj.score, buffer, bufferOffset);
    // Serialize message field [amclPose]
    bufferOffset = _arraySerializer.float32(obj.amclPose, buffer, bufferOffset, null);
    // Serialize message field [visionPose]
    bufferOffset = _arraySerializer.float32(obj.visionPose, buffer, bufferOffset, null);
    // Serialize message field [diff_xy]
    bufferOffset = _serializer.float32(obj.diff_xy, buffer, bufferOffset);
    // Serialize message field [diff_rotate]
    bufferOffset = _serializer.float32(obj.diff_rotate, buffer, bufferOffset);
    // Serialize message field [valid_status]
    bufferOffset = _serializer.bool(obj.valid_status, buffer, bufferOffset);
    // Serialize message field [mismatch_status]
    bufferOffset = _serializer.bool(obj.mismatch_status, buffer, bufferOffset);
    // Serialize message field [unjudge_status]
    bufferOffset = _serializer.bool(obj.unjudge_status, buffer, bufferOffset);
    // Serialize message field [relocal_status]
    bufferOffset = _serializer.int8(obj.relocal_status, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type img_pose_result
    let len;
    let data = new img_pose_result(null);
    // Deserialize message field [stamp]
    data.stamp = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [sim_id]
    data.sim_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [score]
    data.score = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [amclPose]
    data.amclPose = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [visionPose]
    data.visionPose = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [diff_xy]
    data.diff_xy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [diff_rotate]
    data.diff_rotate = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [valid_status]
    data.valid_status = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [mismatch_status]
    data.mismatch_status = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [unjudge_status]
    data.unjudge_status = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [relocal_status]
    data.relocal_status = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.amclPose.length;
    length += 4 * object.visionPose.length;
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'landmark/img_pose_result';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4c390e3b380adc5fc1a15fddc1d5517a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    time stamp
    int32 sim_id
    float32 score
    float32[] amclPose
    float32[] visionPose
    float32 diff_xy
    float32 diff_rotate
    bool valid_status
    bool mismatch_status
    bool unjudge_status
    int8 relocal_status
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new img_pose_result(null);
    if (msg.stamp !== undefined) {
      resolved.stamp = msg.stamp;
    }
    else {
      resolved.stamp = {secs: 0, nsecs: 0}
    }

    if (msg.sim_id !== undefined) {
      resolved.sim_id = msg.sim_id;
    }
    else {
      resolved.sim_id = 0
    }

    if (msg.score !== undefined) {
      resolved.score = msg.score;
    }
    else {
      resolved.score = 0.0
    }

    if (msg.amclPose !== undefined) {
      resolved.amclPose = msg.amclPose;
    }
    else {
      resolved.amclPose = []
    }

    if (msg.visionPose !== undefined) {
      resolved.visionPose = msg.visionPose;
    }
    else {
      resolved.visionPose = []
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

    if (msg.valid_status !== undefined) {
      resolved.valid_status = msg.valid_status;
    }
    else {
      resolved.valid_status = false
    }

    if (msg.mismatch_status !== undefined) {
      resolved.mismatch_status = msg.mismatch_status;
    }
    else {
      resolved.mismatch_status = false
    }

    if (msg.unjudge_status !== undefined) {
      resolved.unjudge_status = msg.unjudge_status;
    }
    else {
      resolved.unjudge_status = false
    }

    if (msg.relocal_status !== undefined) {
      resolved.relocal_status = msg.relocal_status;
    }
    else {
      resolved.relocal_status = 0
    }

    return resolved;
    }
};

module.exports = img_pose_result;
