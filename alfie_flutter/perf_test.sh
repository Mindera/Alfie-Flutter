for i in {1..30}
do
   echo "Starting Performance Run $i/30..."
   flutter drive \
     --driver=test_driver/integration_test.dart \
     --target=integration_test/product_listing_performance_test.dart \
     -d 00008140-001654421A13801C \
     --profile \
     --no-dds
   
   # Move and rename the output file so it isn't overwritten
   mv build/plp_scroll_timeline.timeline_summary.json results/plp_scroll_timeline_run_$i.json
done