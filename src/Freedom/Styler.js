'use strict';

exports._head = function(doc) {
  return function() {
    return doc.head;
  }
}
