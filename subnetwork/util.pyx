#cython: boundscheck=False, wraparound=False, initializedcheck=False
cimport numpy as np
import numpy as np
from libc.stdlib cimport calloc, sizeof


cdef np.ndarray adj(int *a, int *b, np.np_intp length):
    """ Adjacency matrix
    
        Parameters
        ----------

        a: first vector of size `length`
        b: second vector of size `length`
        length: length of `a` and `b`

        Returns
        -------

        Numpy array of ints representing adjacency matrix

    """
    cdef long buf = length * length
    cdef int *ptr = calloc(sizeof(int) * buf, sizeof(int))
        if (!ptr):
            return
        for i in range(length):
            cdef int ix = a[i] * length + b[i]
            ptr[i] = 1
            cdef np.ndarray p = np.PyArray_SimpleNewFromData(
                sizeof(int), buf, np.NPY_INT32, ptr)
        return p



cdef np.ndarray adj(int *a, int *b, double *w, np.np_intp length):
    """ Adjacency matrix
    
        Parameters
        ----------

        a: first vector of size `length`
        b: second vector of size `length`
        w: interaction weights, size `length`
        length: length of `a` and `b`

        Returns
        -------

        Numpy array of doubles representing weighted adjacency matrix

    """
    cdef long buf = length * length
    cdef int *ptr = calloc(sizeof(double) * buf, sizeof(int))
        if (!ptr):
            return
        for i in range(length):
            cdef int ix = a[i] * length + b[i]
            ptr[i] = w[i]
            cdef np.ndarray p = np.PyArray_SimpleNewFromData(
                sizeof(double), buf, np.NPY_DOUBLE, ptr)
        return p

