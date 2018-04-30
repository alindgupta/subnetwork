import pystan as ps
import collections
import sys
import os
import scipy.special import ndtri

"""
data {
  real<lower=0, upper=0> r[];
}

model {
  for (i = 1:m) {
     
  }
}


"""


    
    


def z_scores(p):
    """ Return Z-scores associated with a p-value. 

    Parameters
    ----------
    p : np.ndarray[float] or List[float]
        An array of p-values.

    Returns
    -------
    np.ndarray[float32]
        An array of corresponding Z-scores
        calculated from the inverse cdf of the standard Normal.

    Raises
    ------
    ValueError
        For an invalid p-value (i.e. not in the interval [0, 1])

    """
    p = np.array(p, dtype=np.float32)
    invalid_p = p[(p < 0.0) & (p > 1.0)]
    if invalid_p.size != 0:
        raise ValueError(
            f'Found invalid probability value: {invalid_p}')
    return ndtri(1 - p)


def potential(clique):
    pass


class InteractionGraph:
    """ Interaction graph based on an adjacency matrix
    modelled as a Markov Random Field """
    def __init__(
            self,
            adjacency_matrix,
            ids,
            potentials):

        if adjacency_matrix.shape == potentials.shape:
            raise ValueError('Shape mismatch')
        if length(ids) == adjacency_matrix.shape[0]:
            raise ValueError('Shape mismatch')

        self._adjmat = adjacency_matrix
        self._pot = potentials
        self._dict = ids

    def _get_id(self, name):
        try:
            id_ = self._dict[]
        except KeyError:
            raise ValueError(f'Could not find {name}')

    def markov_blanket(self, name):
        id_ = self._get_id(name)
        connected = np.where(self._adjmat[:,id_] == 1)
        return tuple(self._dict[elem] for elem in connected)

    def degrees(self):
        return np.count_nonzero(self.adjmat)

    @property
    def num_edges(self):
        return np.count_nonzero(self._adjmat)


def convert_to_adj_matrix(df, sparse=True, triangular=True):
    """ Convert to adjacency matrix

    Args:
      df: a data frame containing 2 columns of interaction
      sparse: bool, return a csr_matrix
      triangular: bool, return a lower triangular matrix

    Return:
      Tuple containing
      [1] Dict[str, id], dict of names from df mapped to int 
      [2] Either[np.array, csr_matrix]

    """
    idx = collections.Counter(df.iloc[:, 0])
    adj_matrix = np.zeros(
        (len(idx), len(idx)),
        dtype=np.int32)
    for _, a, b in df.itertuples():
        adj_matrix[idx[a], idx[b]] = 1
    if triangular:
        adj_matrix = np.triu(adj_matrix)
    if sparse:
        adj_matrix = sparse.csr_matrix(adj_matrix)
    return idx, adj_matrix


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--loadfactor',
        '-l',
        default=20)
    parser.add_argument(
        '--file',
        '-f',
        default=None)
    args = parser.parse_args()
