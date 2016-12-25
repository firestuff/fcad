fKeyType = "type";

fTypeUndef = "undef";
fTypeInt = "int";
fTypeFloat = "float";
fTypeString = "string";
fTypeBoolean = "boolean";
fTypeVector = "vector";
fTypeUnknown = "unknown";

function fType(x) = (
  x == undef ? fTypeUndef
  : floor(x) == x ? fTypeInt
  : abs(x) + 1 > abs(x) ? fTypeFloat
  : str(x) == x ? fTypeString
  : str(x) == "false" || str(x) == "true" ? fTypeBoolean
  : fMapLookup(fKeyType, x) ? fMapLookup(fKeyType, x)
  : (x[0] == x[0]) && len(x) != undef ? fTypeVector
  : fTypeUnknown
);

function fIsVector(x) = (
  fType(x) == fTypeVector
);

function fIsInt(x) = (
  fType(x) == fTypeInt
);

function fIsFloat(x) = (
  fType(x) == fTypeFloat
);

function fIsString(x) = (
  fType(x) == fTypeString
);

function fIsBoolean(x) = (
  fType(x) == fTypeBoolean
);

function fIsVector(x) = (
  fType(x) == fTypeVector
);

// Helpers
function fMapLookup(key, model) = (
  [for (pair = model)
   let (iter_key = pair[0],
        iter_value = pair[1])
   if (key == iter_key)
   iter_value][0]
);

function fVectorSlice(vec, start=0, step=undef, end=undef) = (
  let(real_end = (end == undef) ? len(vec) - 1 : end,
      real_step = (step == undef) ?
        ((real_end > start) ? 1 : -1)
        : step)
  [for (i = [start : real_step : real_end])
   vec[i]]
);
