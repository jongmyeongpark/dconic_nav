// Auto-generated. Do not edit!

// (in-package media_controller.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class video_infoRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.rq = null;
    }
    else {
      if (initObj.hasOwnProperty('rq')) {
        this.rq = initObj.rq
      }
      else {
        this.rq = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type video_infoRequest
    // Serialize message field [rq]
    bufferOffset = _serializer.bool(obj.rq, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type video_infoRequest
    let len;
    let data = new video_infoRequest(null);
    // Deserialize message field [rq]
    data.rq = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'media_controller/video_infoRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3f579528a166ca19b05c6b5b4c6da269';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Request video info
    bool rq
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new video_infoRequest(null);
    if (msg.rq !== undefined) {
      resolved.rq = msg.rq;
    }
    else {
      resolved.rq = false
    }

    return resolved;
    }
};

class video_infoResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.videoLength = null;
      this.videoPriority = null;
    }
    else {
      if (initObj.hasOwnProperty('videoLength')) {
        this.videoLength = initObj.videoLength
      }
      else {
        this.videoLength = [];
      }
      if (initObj.hasOwnProperty('videoPriority')) {
        this.videoPriority = initObj.videoPriority
      }
      else {
        this.videoPriority = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type video_infoResponse
    // Serialize message field [videoLength]
    bufferOffset = _arraySerializer.int16(obj.videoLength, buffer, bufferOffset, null);
    // Serialize message field [videoPriority]
    bufferOffset = _arraySerializer.int16(obj.videoPriority, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type video_infoResponse
    let len;
    let data = new video_infoResponse(null);
    // Deserialize message field [videoLength]
    data.videoLength = _arrayDeserializer.int16(buffer, bufferOffset, null)
    // Deserialize message field [videoPriority]
    data.videoPriority = _arrayDeserializer.int16(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 2 * object.videoLength.length;
    length += 2 * object.videoPriority.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'media_controller/video_infoResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '27f9b944b4018a401dc97657a2100843';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int16[] videoLength
    int16[] videoPriority
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new video_infoResponse(null);
    if (msg.videoLength !== undefined) {
      resolved.videoLength = msg.videoLength;
    }
    else {
      resolved.videoLength = []
    }

    if (msg.videoPriority !== undefined) {
      resolved.videoPriority = msg.videoPriority;
    }
    else {
      resolved.videoPriority = []
    }

    return resolved;
    }
};

module.exports = {
  Request: video_infoRequest,
  Response: video_infoResponse,
  md5sum() { return 'c9046fbcc43b98494792b0b94103fa5f'; },
  datatype() { return 'media_controller/video_info'; }
};
