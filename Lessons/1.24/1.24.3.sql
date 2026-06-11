UPDATE main.job_skill_priorities
SET status = 'URGENT'
WHERE status = 'ACTIVE';

SELECT *
from job_skill_priorities;