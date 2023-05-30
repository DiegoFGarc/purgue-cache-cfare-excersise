PurgeCache() {
    URL=$1
    echo "Purging Cloudflare cache for: $URL"
    if [[ $zone_id != '' ]]; then
      response=$(curl --request POST --url https://api.cloudflare.com/client/v4/zones/$zone_id/purge_cache \
          --header "Content-Type: application/json" \
          --header "Authorization: Bearer $TOKEN_CLOUDFLARE_API" \
          --data "{\"hosts\": [\"$URL\"]}")  
    fi
    if echo "$response" | grep -q '"success": true'; then
      echo "INFO: Cache purged successfully for $URL"
      echo "$response"
    else
      echo "ERROR: There were some errors purging the cache:"
      echo "$response"
    fi
  }