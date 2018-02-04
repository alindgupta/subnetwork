#include <iostream>
#include <Boost/Python>

int* adjacency_matrix(const int *a, const int *b, const std::size_t length) {
  int *ptr = (int*)calloc(sizeof(int) * (length * length), sizeof(int));
  if (!ptr) {
    return nullptr;
  }
  for (int i = 0; i < length; i++) {
    int ix = a[i] * length + b[i];
    ptr[ix] = 1;
  }
  return ptr;
}

double *adjacency_matrix(const int *a, const int *b, const double *c, const std::size_t length) {
  double *ptr = (double*)calloc(sizeof(int) * (length * length), sizeof(int));
  if (!ptr) {
    return nullptr;
  }
  for (int i = 0; i < length; i++) {
    int ix = a[i] * length + b[i];
    ptr[ix] = c[i];
  }
  return ptr;
}

int *adjacency_matrix_upper(const int *a, const int *b, const std::size_t length) {
  auto sum = [](int i) -> int {
    int sum_ = 0;
    for (int j = 1; j <= i; j++) {
      sum_ += j;
    }
    return sum_;
  };
  int num_elems = length * length - sum(length - 1);
  std::cout << num_elems << '\n';
  int *ptr = (int*)calloc(sizeof(int) * num_elems, sizeof(int));
  
  return ptr;
}
