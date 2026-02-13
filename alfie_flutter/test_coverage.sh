flutter test --coverage --branch-coverage

lcov --remove coverage/lcov.info \
  'lib/graphql/generated/**' \
  -o coverage/lcov.info --branch-coverage --ignore-errors inconsistent,corrupt

if [ "$GITHUB_ACTIONS" != "true" ]; then
  genhtml coverage/lcov.info -o coverage/html --branch-coverage --ignore-errors inconsistent,corrupt

  open coverage/html/index.html
fi
