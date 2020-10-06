import 'dart:convert';

enum EscapeType {
  text,
  at,
  link,
}

class EscapeBlock {
  EscapeBlock(this.type, this.data);

  EscapeType type;
  dynamic data;

  @override
  String toString() {
    return '{type: $type, data: $data}';
  }
}

Map<String, String> _escapeCharacter = {
  "&amp;": "&",
  "&lt;": "<",
  "&gt;": ">",
  "&eq;": "=",
  "&colon;": ":"
};

String escape(List<EscapeBlock> comment) {
  String ret = "";
  comment.forEach((block) {
    switch (block.type) {
      case EscapeType.at:
        ret += _atEscape(block.data);
        break;
      case EscapeType.link:
        ret += _linkEscape(block.data);
        break;
      case EscapeType.text:
        ret += _textEscape(block.data);
        break;
      default:
    }
  });
  return ret;
}

List<EscapeBlock> unescape(String comment) {
  List<int> temp = [];
  bool flag = false;

  var utf = Utf8Codec();
  var strs = utf.encode(comment);
  int index = 0;
  List<EscapeBlock> ret = [];
  while (strs.length > index) {
    if (strs[index] == 0x3c) {
      // <: 0x3c
      flag = true;
      if (temp.length > 0) {
        ret.add(new EscapeBlock(EscapeType.text, _textUnescape(utf.decode(temp))));
        temp.clear();
      }
    }
    temp.add(strs[index]);
    if (strs[index] == 0x3e && flag) {
      // >: 0x3e
      if (utf.decode(temp).startsWith('<zl:at')) {
        int id = _atUnescape(utf.decode(temp));
        ret.add(new EscapeBlock(EscapeType.at, id));
      } else if (utf.decode(temp).startsWith('<zl:link')) {
        String link = _linkUnescape(utf.decode(temp));
        ret.add(new EscapeBlock(EscapeType.link, link));
      } else {
        ret.add(new EscapeBlock(EscapeType.text, _textUnescape(utf.decode(temp))));
      }
      temp.clear();
      flag = false;
    }
    if (strs.length - 1 == index && temp.length > 0) {
      ret.add(new EscapeBlock(EscapeType.text, _textUnescape(utf.decode(temp))));
      temp.clear();
    }
    ++index;
  }
  return ret;
}

String _textEscape(String t) {
  for (var escape in _escapeCharacter.keys) {
    t = t.replaceAll(new RegExp(_escapeCharacter[escape]), escape);
  }
  return t;
}

String _textUnescape(String t) {
  for (var escape in _escapeCharacter.keys.toList().reversed) {
    t = t.replaceAll(new RegExp(escape), _escapeCharacter[escape]);
  }
  return t;
}

String _atEscape(int id) {
  return '<zl:at id=$id>';
}

int _atUnescape(String a) {
  var match = RegExp(r'<zl:at id=(\d+)>').firstMatch(a);
  if (match == null) return null;
  return int.parse(match.group(1));
}

String _linkEscape(String link) {
  String protocol;
  if (link.contains('://')) {
    protocol = link.split('://')[0];
    link = link.split('://')[1];
  }
  link = Uri.encodeComponent(link);
  return '<zl:link href=$protocol://$link>';
}

String _linkUnescape(String l) {
  var match = RegExp(r'<zl:link href=(.+)>').firstMatch(l);
  if (match == null) return null;
  return Uri.decodeComponent(match.group(1));
}
