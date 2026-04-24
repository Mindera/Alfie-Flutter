# Temporarily disable "exit on error"
set +e

flutter test --coverage --branch-coverage

TEST_EXIT_CODE=$?

# Re-enable "exit on error"
set -e

lcov --remove coverage/lcov.info \
  'lib/graphql/generated/**' \
  --remove coverage/lcov.info \
  'lib/data/backend/**' \
  --remove coverage/lcov.info \
  'lib/ui/core/ui/components_demo_screen/**' \
    --remove coverage/lcov.info \
  'lib/ui/core/themes/**' \
  -o coverage/lcov.info --branch-coverage --ignore-errors inconsistent,inconsistent


if [ "$GITHUB_ACTIONS" != "true" ]; then
  genhtml coverage/lcov.info -o coverage/html --branch-coverage \
    --rc genhtml_hi_limit=80 \
  --rc genhtml_med_limit=70 \
  --ignore-errors inconsistent,inconsistent

  open coverage/html/index.html
fi

exit $TEST_EXIT_CODE