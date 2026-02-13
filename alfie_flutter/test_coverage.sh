flutter test --coverage --branch-coverage

lcov --remove coverage/lcov.info \
  'lib/graphql/generated/**' \
  -o coverage/lcov.info --branch-coverage --ignore-errors inconsistent


genhtml coverage/lcov.info -o coverage/html --branch-coverage --ignore-errors inconsistent

open coverage/html/index.html
