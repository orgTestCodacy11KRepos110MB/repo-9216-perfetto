--
-- Copyright 2022 The Android Open Source Project
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

SELECT IMPORT('android.binder');

-- Count Binder transactions per process
DROP VIEW IF EXISTS binder_metrics_by_process;
CREATE VIEW binder_metrics_by_process AS
SELECT * FROM android_binder_metrics_by_process;

DROP VIEW IF EXISTS android_binder_output;
CREATE VIEW android_binder_output AS
SELECT AndroidBinderMetric(
  'process_breakdown', (
    SELECT RepeatedField(
      AndroidBinderMetric_PerProcessBreakdown(
        'process_name', process_name,
        'pid', pid,
        'slice_name', slice_name,
        'count', event_count
      )
    )
    FROM android_binder_metrics_by_process
  )
);
