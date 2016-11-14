#defines which class will be invoked asynchronously for Payment writing
create async-event-queue --listener=com.tmo.payments.server.cacheevents.PaymentDbSynchronizer --id=1

# static entries will be deleted if not accessed in 36 hours.
# Note: a better practice is to write a client program that will delete entries that were deleted from DB
create region --name=PaymentTypeConfig --type=REPLICATE_PERSISTENT --cache-loader=com.tmo.payments.server.cacheevents.PaymentTypeConfigCacheLoader --entry-idle-time-expiration=129600 --entry-idle-time-expiration-action=destroy --enable-statistics=true

# Payments will survive node outages and has an event queue attached
create region --name=Payments --type=PARTITION_REDUNDANT_PERSISTENT --async-event-queue-id=1

create region --name=PaymentDuplicateKeys --type=PARTITION_REDUNDANT_PERSISTENT

# initialize the payments region with simple test data
put --region=Payments --key="0" --value=('id':"0",'clientId':'a','msidsn':'b','ban':'c','customerId':'d','orderId':'e','amount':'f','ccLast4':'g') --value-class=com.tmo.payments.domain.Payment
put --region=PaymentTypeConfig --key='CSCO' --value=('clientId':'CSCO') --value-class=com.tmo.payments.domain.PaymentTypeConfig
