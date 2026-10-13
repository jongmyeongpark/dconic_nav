// Auto-generated. Do not edit!

// (in-package media_controller.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class VideoPriority {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.videoPriority = null;
    }
    else {
      if (initObj.hasOwnProperty('videoPriority')) {
        this.videoPriority = initObj.videoPriority
      }
      else {
        this.videoPriority = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type VideoPriority
    // Serialize message field [videoPriority]
    bufferOffset = _arraySerializer.uint32(obj.videoPriority, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type VideoPriority
    let len;
    let data = new VideoPriority(null);
    // Deserialize message field [videoPriority]
    data.videoPriority = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.videoPriority.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'media_controller/VideoPriority';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2d9b44b37b25759f764816c03dd5c4ee';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32[] videoPriority
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new VideoPriority(null);
    if (msg.videoPriority !== undefined) {
      resolved.videoPriority = msg.videoPriority;
    }
    else {
      resolved.videoPriority = []
    }

    return resolved;
    }
};

module.exports = VideoPriority;
