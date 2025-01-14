set -e

sleep 1000

# check if cluster is paused
aws ecs describe-clusters --cluster $CLUSTER_NAME | jq -r '.clusters[0].status' | grep -q "INACTIVE"

if [ $? -eq 0 ]; then
  echo "Cluster is paused"
else
  echo "Cluster is not paused"
fi
