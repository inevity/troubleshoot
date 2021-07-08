!/bin/bash
git filter-branch --env-filter '
   if [ "$GIT_AUTHOR_EMAIL" = baojg@taocloudx.com ]; then
     GIT_AUTHOR_EMAIL=roidinev@gmail.com	
   fi
 ' HEAD
