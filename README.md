# Automatic Grading System for Purdue University

## Development Setup

### External Dependencies

* [Ruby 2.2.4](http://www.ruby-lang.org)
* [Rails 4.2](http://rubyonrails.org)
* [PostgreSQL](https://www.postgresql.org)

### Setup

1. Fetch grading-system repository

  ```shell
  git clone https://github.com/rakibulislam/grading-system.git
  cd grading-system
  ```

2. Install required gems

  ```shell
  bundle install
  ```

3. Copy config/database.yml.sample as config/database.yml and configure. If you
   are using deebee, an example config is provided.

  ```shell
  cp config/database.yml.sample config/database.yml
  ```

4. Run the database migrations.

  ```shell
  bundle exec rake db:create
  bundle exec rake db:migrate
  ```

5. Start the server

  ```shell
  bundle exec rails server --port=3000
  ```

6. Visit the application:
  ```shell
  http://localhost:3000
  ```

7. The application is deployed on heroku and hosted here:
  ```shell
  http://www.portalpurdueironhacks.com
  ```
    
### Available Rake Tasks

  ```shell
  rake graders:send_reminder_email_to_technical_graders   # send reminder emails to technical graders
  rake graders:send_reminder_email_to_usability_graders   # send reminder emails to usability graders
  rake hack_1:send_reminder_to_students_for_1st_phase     # send reminder emails to students for 1st phase (Gold IronHack)
  rake hack_1:send_reminder_to_students_for_2nd_phase     # send reminder emails to students for 2nd phase (Gold IronHack)
  rake hack_1:send_reminder_to_students_for_3rd_phase     # send reminder emails to students for 3rd phase (Gold IronHack)
  rake hack_1:send_reminder_to_students_for_final_phase   # send reminder emails to students for Final phase (Gold IronHack)
  rake hack_1_project:send_email_to_students_1st_phase    # send performance reports to students for 1st phase (Gold IronHack)
  rake hack_1_project:send_email_to_students_2nd_phase    # send performance reports to students for 2nd phase (Gold IronHack)
  rake hack_1_project:send_email_to_students_3rd_phase    # send performance reports to students for 3rd phase (Gold IronHack)
  rake hack_1_project:send_email_to_students_final_phase  # send performance reports to students for final phase (Gold IronHack)
  rake hack_2:send_reminder_to_students_for_1st_phase     # send reminder emails to students for 1st phase (Black IronHack)
  rake hack_2:send_reminder_to_students_for_2nd_phase     # send reminder emails to students for 2nd phase (Black IronHack)
  rake hack_2:send_reminder_to_students_for_3rd_phase     # send reminder emails to students for 3rd phase (Black IronHack)
  rake hack_2:send_reminder_to_students_for_final_phase   # send reminder emails to students for Final phase (Black IronHack)
  rake hack_2_project:send_email_to_students_1st_phase    # send performance reports to students for 1st phase (Black IronHack)
  rake hack_2_project:send_email_to_students_2nd_phase    # send performance reports to students for 2nd phase (Black IronHack)
  rake hack_2_project:send_email_to_students_3rd_phase    # send performance reports to students for 3rd phase (Black IronHack)
  rake hack_2_project:send_email_to_students_final_phase  # send performance reports to students for final phase (Black IronHack)
  rake bogota_ironhack_projects:bogota_0_send_email_to_students_1st_phase    # Bogota-Hack-0-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_0_send_email_to_students_2nd_phase    # Bogota-Hack-0-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_0_send_email_to_students_3rd_phase    # Bogota-Hack-0-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_0_send_email_to_students_4th_phase    # Bogota-Hack-0-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_0_send_email_to_students_5th_phase    # Bogota-Hack-0-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_1_send_email_to_students_1st_phase    # Bogota-Hack-1-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_1_send_email_to_students_2nd_phase    # Bogota-Hack-1-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_1_send_email_to_students_3rd_phase    # Bogota-Hack-1-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_1_send_email_to_students_4th_phase    # Bogota-Hack-1-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_1_send_email_to_students_5th_phase    # Bogota-Hack-1-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_2_send_email_to_students_1st_phase    # Bogota-Hack-2-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_2_send_email_to_students_2nd_phase    # Bogota-Hack-2-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_2_send_email_to_students_3rd_phase    # Bogota-Hack-2-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_2_send_email_to_students_4th_phase    # Bogota-Hack-2-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_2_send_email_to_students_5th_phase    # Bogota-Hack-2-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_3_send_email_to_students_1st_phase    # Bogota-Hack-3-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_3_send_email_to_students_2nd_phase    # Bogota-Hack-3-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_3_send_email_to_students_3rd_phase    # Bogota-Hack-3-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_3_send_email_to_students_4th_phase    # Bogota-Hack-3-2017 Hack: send performance reports to stud...
  rake bogota_ironhack_projects:bogota_3_send_email_to_students_5th_phase    # Bogota-Hack-3-2017 Hack: send performance reports to stud...
  ```
