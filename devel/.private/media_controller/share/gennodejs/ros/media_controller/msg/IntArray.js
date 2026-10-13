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

class IntArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.intArray = null;
    }
    else {
      if (initObj.hasOwnProperty('intArray')) {
        this.intArray = initObj.intArray
      }
      else {
        this.intArray = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type IntArray
    // Serialize message field [intArray]
    bufferOffset = _arraySerializer.uint32(obj.intArray, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type IntArray
    let len;
    let data = new IntArray(null);
    // Deserialize message field [intArray]
    data.intArray = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.intArray.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'media_controller/IntArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '76f7d7f74f2e8dcdd4ba703281016923';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32[] intArray
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new IntArray(null);
    if (msg.intArray !== undefined) {
      resolved.intArray = msg.intArray;
    }
    else {
      resolved.intArray = []
    }

    return resolved;
    }
};

module.exports = IntArray;
