#!/bin/bash

aws s3 sync ./texts s3://text-delivery/texts
curl http://staging2.diveintocode.jp/api/v1/textbooks/bulk_modify -X PUT
