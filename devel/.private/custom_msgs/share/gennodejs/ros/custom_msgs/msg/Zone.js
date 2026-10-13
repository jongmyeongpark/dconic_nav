// Auto-generated. Do not edit!

// (in-package custom_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Form = require('./Form.js');

//-----------------------------------------------------------

class Zone {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.area = null;
    }
    else {
      if (initObj.hasOwnProperty('area')) {
        this.area = initObj.area
      }
      else {
        this.area = new Form();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Zone
    // Serialize message field [area]
    bufferOffset = Form.serialize(obj.area, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Zone
    let len;
    let data = new Zone(null);
    // Deserialize message field [area]
    data.area = Form.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += Form.getMessageSize(object.area);
    return length;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msgs/Zone';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '033c166c5de606dccad7a8a825be6a5d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    custom_msgs/Form area         
    
    ================================================================================
    MSG: custom_msgs/Form
    geometry_msgs/Point[] form         
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Zone(null);
    if (msg.area !== undefined) {
      resolved.area = Form.Resolve(msg.area)
    }
    else {
      resolved.area = new Form()
    }

    return resolved;
    }
};

module.exports = Zone;
