'use strict';

exports.setForeign = function(name) {
  return function(foreign) {
    return function(element) {
      return function() {
        element[name] = foreign;
      }
    }
  }
}

exports.setAttributeNS = function(ns) {
  return function(name) {
    return function(val) {
      return function(element) {
        return function() {
          element.setAttributeNS(ns, name, val);
          return {};
        }
      }
    }
  }
}

exports.removeAttributeNS = function(ns) {
  return function(name) {
    return function(element) {
      return function() {
        element.removeAttributeNS(ns, name);
        return {};
      }
    }
  }
}

exports.isProperty = function(name) {
  return function(element) {
    return name in element;
  }
}

exports.isBoolean = function(name) {
  return function(element) {
    return typeof element[name] === "boolean";
  }
}
