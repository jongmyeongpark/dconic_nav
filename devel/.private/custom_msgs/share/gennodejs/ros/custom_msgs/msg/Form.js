// Auto-generated. Do not edit!

// (in-package custom_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class Form {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.form = null;
    }
    else {
      if (initObj.hasOwnProperty('form')) {
        this.form = initObj.form
      }
      else {
        this.form = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Form
    // Serialize message field [form]
    // Serialize the length for message field [form]
    bufferOffset = _serializer.uint32(obj.form.length, buffer, bufferOffset);
    obj.form.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Form
    let len;
    let data = new Form(null);
    // Deserialize message field [form]
    // Deserialize array length for message field [form]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.form = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.form[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 24 * object.form.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msgs/Form';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '46c4b2c357456de61f855d80140cd91b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new Form(null);
    if (msg.form !== undefined) {
      resolved.form = new Array(msg.form.length);
      for (let i = 0; i < resolved.form.length; ++i) {
        resolved.form[i] = geometry_msgs.msg.Point.Resolve(msg.form[i]);
      }
    }
    else {
      resolved.form = []
    }

    return resolved;
    }
};

module.exports = Form;
