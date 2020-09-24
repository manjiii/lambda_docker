
import boto3

def lambda_handler(event, context):

    message = event.get('event_message')

    return {
        'message': message
    }
