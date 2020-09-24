
import boto3

def lambda_handler(event, context):

    message = event.get('event_message')

    return {
        'message': message
    }



# for local test
if __name__ == '__main__':
    import json
    with open('lambda_param.json') as f:
        df = json.load(f)

    result = lambda_handler(df, {})
    print(f'result:{result}')


