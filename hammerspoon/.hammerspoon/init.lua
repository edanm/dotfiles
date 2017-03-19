-- Bind the q to the shift key.
shifted = false

hs.hotkey.bind({"alt"}, "q", function()
  shifted = true
end, function()
  shifted = false
end)

-- This does a keystroke without a delay.
myDoKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

-- This does a key stroke, but if we're in "shifted" mode, will add a shift.
doKeyWithShiftSupport = function (modifiers, character)
  local event = require("hs.eventtap").event
  if not shifted then
    myDoKeyStroke(modifiers, character)
  else
    table.insert(modifiers,"shift")
    myDoKeyStroke(modifiers, character)
  end
end

doKeyWithShift = function(nonshift_func, shift_func)
  if not shifted then
    nonshift_func()
  else
    shift_func()
  end
end


-- Standard bindings (regular shifted bindings).

-- Arrow keys.
key_h = function() doKeyWithShiftSupport({}, "left") end
hs.hotkey.bind({"alt"}, "h", key_h, nil, key_h)

key_j = function() doKeyWithShiftSupport({}, "down") end
hs.hotkey.bind({"alt"}, "j", key_j, nil, key_j)

key_k = function() doKeyWithShiftSupport({}, "up") end
hs.hotkey.bind({"alt"}, "k", key_k, nil, key_k)

key_l = function() doKeyWithShiftSupport({}, "right") end
hs.hotkey.bind({"alt"}, "l", key_l, nil, key_l)

-- 0 = home, 4 = end
key_zero = function() doKeyWithShiftSupport({"cmd"}, "left") end
hs.hotkey.bind({"alt"}, "0", key_zero, nil, key_zero)
key_four = function() doKeyWithShiftSupport({"cmd"}, "right") end
hs.hotkey.bind({"alt"}, "4", key_four, nil, key_four)

-- = = Document End
key_equals = function() doKeyWithShiftSupport({"cmd"}, "down") end
hs.hotkey.bind({"alt"}, "=", key_equals, nil, key_equals)

-- - = Document End
key_minus = function() doKeyWithShiftSupport({"cmd"}, "up") end
hs.hotkey.bind({"alt"}, "-", key_minus, nil, key_minus)

-- o = forwards by word
key_o = function() doKeyWithShiftSupport({"alt"}, "right") end
hs.hotkey.bind({"alt"}, "o", key_o, nil, key_o)

-- u = backwards by word
key_u = function() doKeyWithShiftSupport({"alt"}, "left") end
hs.hotkey.bind({"alt"}, "u", key_u, nil, key_u)

-- , = pgdown
key_comma = function() doKeyWithShiftSupport({}, "pagedown") end
hs.hotkey.bind({"alt"}, ",", key_comma, nil, key_comma)

-- 8 = pgup
key_eight = function() doKeyWithShiftSupport({}, "pageup") end
hs.hotkey.bind({"alt"}, "8", key_eight, nil, key_eight)

-- Non-standard key bindings (not a single-char map, or shifted is not just adding a shift, it's a
-- different meaning).

-- . = up * 4
key_dot = function()
  if not shifted then
    myDoKeyStroke({""}, "up")
    myDoKeyStroke({""}, "up")
    myDoKeyStroke({""}, "up")
    myDoKeyStroke({""}, "up")
  else
    myDoKeyStroke({"shift"}, "up")
    myDoKeyStroke({"shift"}, "up")
    myDoKeyStroke({"shift"}, "up")
    myDoKeyStroke({"shift"}, "up")
  end
end
hs.hotkey.bind({"alt"}, ".", key_dot, nil, key_dot)

-- m = down * 4
key_m = function()
  if not shifted then
    myDoKeyStroke({""}, "down")
    myDoKeyStroke({""}, "down")
    myDoKeyStroke({""}, "down")
    myDoKeyStroke({""}, "down")
  else
    myDoKeyStroke({"shift"}, "down")
    myDoKeyStroke({"shift"}, "down")
    myDoKeyStroke({"shift"}, "down")
    myDoKeyStroke({"shift"}, "down")
  end
end
hs.hotkey.bind({"alt"}, "m", key_m, nil, key_m)

-- i = Enter, shift+i = insert new line.
key_i = function() doKeyWithShift(function()
    myDoKeyStroke({""}, "return")
  end, function()
    myDoKeyStroke({"cmd"}, "right")
    myDoKeyStroke({}, "return")
  end)
end
hs.hotkey.bind({"alt"}, "i", key_i, nil, key_i)

-- ; = Escape.
key_semicolon = function() myDoKeyStroke({}, "escape") end
hs.hotkey.bind({"alt"}, ";", key_semicolon, nil, key_semicolon)

-- n = backspace, shift+n = backspace * 4
key_n = function() doKeyWithShift(function()
    myDoKeyStroke({""}, "delete")
  end, function()
    myDoKeyStroke({"shift"}, "delete")
    myDoKeyStroke({"shift"}, "delete")
    myDoKeyStroke({"shift"}, "delete")
    myDoKeyStroke({"shift"}, "delete")
  end)
end
hs.hotkey.bind({"alt"}, "n", key_n, nil, key_n)

-- c = delete, shift+n = delete * 4
key_c = function() doKeyWithShift(function()
    myDoKeyStroke({""}, "forwarddelete")
  end, function()
    myDoKeyStroke({"shift"}, "forwarddelete")
    myDoKeyStroke({"shift"}, "forwarddelete")
    myDoKeyStroke({"shift"}, "forwarddelete")
    myDoKeyStroke({"shift"}, "forwarddelete")
  end)
end
hs.hotkey.bind({"alt"}, "c", key_c, nil, key_c)

-- [ = tab right, shift+[ = close tab
key_lbrack = function() doKeyWithShift(function()
    myDoKeyStroke({"cmd", "shift"}, "[")
  end, function()
    myDoKeyStroke({"cmd", "shift"}, "{")
  end)
end
hs.hotkey.bind({"alt"}, "[", key_lbrack, nil, key_lbrack)

-- d = select inner word
key_d = function() 
    myDoKeyStroke({"alt"}, "left")
    myDoKeyStroke({"alt", "shift"}, "right")
end
hs.hotkey.bind({"alt"}, "d", key_d, nil, key_d)

-- e = backwards delete line, shift+e = forwards delete line 
key_e = function() doKeyWithShift(function()
    myDoKeyStroke({"cmd"}, "delete")
  end, function()
    myDoKeyStroke({"cmd", "shift"}, "right")
    myDoKeyStroke({}, "delete")
  end)
end
hs.hotkey.bind({"alt"}, "e", key_e, nil, key_e)

-- r = select line, shift+r = delete line (dd)
key_r = function() doKeyWithShift(function()
    myDoKeyStroke({"cmd"}, "left")
    myDoKeyStroke({"cmd", "shift"}, "right")
  end, function()
    myDoKeyStroke({"cmd"}, "left")
    myDoKeyStroke({"cmd", "shift"}, "right")
    myDoKeyStroke({}, "delete")
    myDoKeyStroke({}, "delete")
    myDoKeyStroke({"cmd"}, "left")
  end)
end
hs.hotkey.bind({"alt"}, "r", key_r, nil, key_r)

-- return = down after line, shift+return = down before line
key_return = function() doKeyWithShift(function()
    myDoKeyStroke({"cmd"}, "right")
    myDoKeyStroke({}, "return")
  end, function()
    myDoKeyStroke({"cmd"}, "left")
    myDoKeyStroke({}, "return")
    myDoKeyStroke({}, "up")
  end)
end
hs.hotkey.bind({"alt"}, "return", key_return, nil, key_return)

-- w = delete last word, shift+w = forward delete word
key_w = function() doKeyWithShift(function()
    myDoKeyStroke({"alt"}, "delete")
  end, function()
    myDoKeyStroke({"alt"}, "forwarddelete")
  end)
end
hs.hotkey.bind({"alt"}, "w", key_w, nil, key_w)

-- f = (f)orward 20 chara
key_f = function() doKeyWithShift(function()
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
  end, function()
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
  end)
end
hs.hotkey.bind({"alt"}, "f", key_f, nil, key_f)

-- g = forward 4 chars (cause it's to the right of f).
key_g = function() doKeyWithShift(function()
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
    myDoKeyStroke({}, "right")
  end, function()
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
    myDoKeyStroke({"shift"}, "right")
  end)
end
hs.hotkey.bind({"alt"}, "g", key_g, nil, key_g)


