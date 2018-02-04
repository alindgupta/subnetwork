#cython: boundscheck=False, wraparound=False, initializedcheck=False
cimport numpy as np
import numpy as np
from libc.stdlib cimport calloc

np.import_array()


cdef np.ndarray adj(int *a, int *b, np.npy_intp length):
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
    cdef np.npy_intp buf = length * length
    cdef int *ptr = <int*>calloc(sizeof(int) * buf, sizeof(int))
    if not ptr:
        return
    cdef int ix = 0
    for i in range(length):
        ix = a[i] * length + b[i]
        ptr[ix] = 1
    cdef np.ndarray p = np.PyArray_SimpleNewFromData(
        1, &buf, np.NPY_INT, ptr)
    return p



cdef np.ndarray adjw(int *a, int *b, double *w, np.npy_intp length):
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
    cdef np.npy_intp buf = length * length
    cdef double *ptr = <double*>calloc(sizeof(double) * buf, sizeof(int))
    if not ptr:
        return
    cdef int ix = 0
    for i in range(length):
        ix = a[i] * length + b[i]
        ptr[i] = w[i]
    cdef np.ndarray p = np.PyArray_SimpleNewFromData(
        1, &buf, np.NPY_DOUBLE, ptr)
    return p
