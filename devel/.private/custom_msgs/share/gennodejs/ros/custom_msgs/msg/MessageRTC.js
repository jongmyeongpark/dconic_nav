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

class MessageRTC {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.action = null;
      this.sender = null;
      this.sdp = null;
      this.type = null;
      this.candidate = null;
      this.sdpMid = null;
      this.sdpMLineIndex = null;
      this.stream = null;
    }
    else {
      if (initObj.hasOwnProperty('action')) {
        this.action = initObj.action
      }
      else {
        this.action = '';
      }
      if (initObj.hasOwnProperty('sender')) {
        this.sender = initObj.sender
      }
      else {
        this.sender = '';
      }
      if (initObj.hasOwnProperty('sdp')) {
        this.sdp = initObj.sdp
      }
      else {
        this.sdp = '';
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = '';
      }
      if (initObj.hasOwnProperty('candidate')) {
        this.candidate = initObj.candidate
      }
      else {
        this.candidate = '';
      }
      if (initObj.hasOwnProperty('sdpMid')) {
        this.sdpMid = initObj.sdpMid
      }
      else {
        this.sdpMid = '';
      }
      if (initObj.hasOwnProperty('sdpMLineIndex')) {
        this.sdpMLineIndex = initObj.sdpMLineIndex
      }
      else {
        this.sdpMLineIndex = 0;
      }
      if (initObj.hasOwnProperty('stream')) {
        this.stream = initObj.stream
      }
      else {
        this.stream = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MessageRTC
    // Serialize message field [action]
    bufferOffset = _serializer.string(obj.action, buffer, bufferOffset);
    // Serialize message field [sender]
    bufferOffset = _serializer.string(obj.sender, buffer, bufferOffset);
    // Serialize message field [sdp]
    bufferOffset = _serializer.string(obj.sdp, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.string(obj.type, buffer, bufferOffset);
    // Serialize message field [candidate]
    bufferOffset = _serializer.string(obj.candidate, buffer, bufferOffset);
    // Serialize message field [sdpMid]
    bufferOffset = _serializer.string(obj.sdpMid, buffer, bufferOffset);
    // Serialize message field [sdpMLineIndex]
    bufferOffset = _serializer.int32(obj.sdpMLineIndex, buffer, bufferOffset);
    // Serialize message field [stream]
    bufferOffset = _serializer.string(obj.stream, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MessageRTC
    let len;
    let data = new MessageRTC(null);
    // Deserialize message field [action]
    data.action = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [sender]
    data.sender = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [sdp]
    data.sdp = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [candidate]
    data.candidate = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [sdpMid]
    data.sdpMid = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [sdpMLineIndex]
    data.sdpMLineIndex = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [stream]
    data.stream = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.action);
    length += _getByteLength(object.sender);
    length += _getByteLength(object.sdp);
    length += _getByteLength(object.type);
    length += _getByteLength(object.candidate);
    length += _getByteLength(object.sdpMid);
    length += _getByteLength(object.stream);
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'custom_msgs/MessageRTC';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd26b43f04c953b94dfeecbe80ac33399';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string action
    string sender
    string sdp 
    string type
    string candidate
    string sdpMid
    int32 sdpMLineIndex
    string stream
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MessageRTC(null);
    if (msg.action !== undefined) {
      resolved.action = msg.action;
    }
    else {
      resolved.action = ''
    }

    if (msg.sender !== undefined) {
      resolved.sender = msg.sender;
    }
    else {
      resolved.sender = ''
    }

    if (msg.sdp !== undefined) {
      resolved.sdp = msg.sdp;
    }
    else {
      resolved.sdp = ''
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = ''
    }

    if (msg.candidate !== undefined) {
      resolved.candidate = msg.candidate;
    }
    else {
      resolved.candidate = ''
    }

    if (msg.sdpMid !== undefined) {
      resolved.sdpMid = msg.sdpMid;
    }
    else {
      resolved.sdpMid = ''
    }

    if (msg.sdpMLineIndex !== undefined) {
      resolved.sdpMLineIndex = msg.sdpMLineIndex;
    }
    else {
      resolved.sdpMLineIndex = 0
    }

    if (msg.stream !== undefined) {
      resolved.stream = msg.stream;
    }
    else {
      resolved.stream = ''
    }

    return resolved;
    }
};

module.exports = MessageRTC;
