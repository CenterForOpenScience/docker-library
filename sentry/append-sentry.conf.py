
if 'GOOGLE_CLIENT_ID' in os.environ:
    GOOGLE_CLIENT_ID = env('GOOGLE_CLIENT_ID')
    GOOGLE_CLIENT_SECRET = env('GOOGLE_CLIENT_SECRET')

if 'SENTRY_WEB_OPTIONS' in os.environ:
    import json

    options = json.loads(env('SENTRY_WEB_OPTIONS'))
    SENTRY_WEB_OPTIONS.update(options)
