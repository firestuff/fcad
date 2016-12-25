function fCartesianProduct(vecs) = (
  len(vecs) == 1 ?
    vecs[0]
    :
    [for (val1 = vecs[0])
     for (val2 = fCartesianProduct(fVectorSlice(vecs, start=1)))
     concat(val1, val2)]
);

