--
-- Copyright 2019 The Android Open Source Project
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
SELECT
  value,
  sum(dur) AS dur_sum
FROM (
  SELECT value,
    lead(ts) OVER (PARTITION BY name, track_id ORDER BY ts) - ts AS dur
  FROM counter
  JOIN counter_track ON counter.track_id = counter_track.id
)
WHERE value > 0
GROUP BY value
ORDER BY dur_sum DESC;
