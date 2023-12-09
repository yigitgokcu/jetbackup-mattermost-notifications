# How to Setup Mattermost Notifications

Create a bash script to send a webhook notification on your channel and copy the Webhook URL from the Mattermost App created into the MATTERMOST_WEBHOOK_URL portion of the script.

> Make sure that your script has the appropriate executable permission (chmod +x /path/to/script.sh)

Create a JetBackup Pre and Post Backup Job Hook and specify the path to your bash script.

WHM > JetBackup > Hooks > Create New Hook:
1) Hook Name: pre-Backup mattermost notification/post-Backup mattermost notification
2) Hook Position: pre/post
3) Hook Type: Backup
4) Backup Jobs: {Specify your preferred backup jobs or leave blank to apply for all backup jobs}

![image](https://user-images.githubusercontent.com/59539521/111876641-b5aa0500-89b0-11eb-931d-d6bf19f13ac9.png)

Once your Hooks are set up, you will start receiving notifications on the mattermost channel depending on your script and hook type. In this case, sending notifications for when a backup starts and finishes and the corresponding status of the backup job.

You could also add customizations and advanced formatting to your mattermost notification layout with the use of mattermost’s [text formatting](https://docs.mattermost.com/help/messaging/formatting-text.html)

Source: https://blog.jetapps.com/how-to-setup-slack-notifications/
