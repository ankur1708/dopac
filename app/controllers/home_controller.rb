class HomeController < ApplicationController

	def signing
		bucket = "YOUR_BUCKET_NAME",
    	awsKey = "YOUR_AWS_USER_KEY",
    	secret = "YOUR_AWS_USER_SECRET";

	    var fileName = req.body.fileName,
	    expiration = new Date(new Date().getTime() + 1000 * 60 * 5).toISOString();
	 
	    var policy =
	    { "expiration": expiration,
	        "conditions": [
	            {"bucket": bucket},
	            {"key": fileName},
	            {"acl": 'public-read'},
	            ["starts-with", "$Content-Type", ""],
	            ["content-length-range", 0, 524288000]
	        ]};
	 
	    policyBase64 = new Buffer(JSON.stringify(policy), 'utf8').toString('base64');
	    signature = crypto.createHmac('sha1', secret).update(policyBase64).digest('base64');
	    res.json({bucket: bucket, awsKey: awsKey, policy: policyBase64, signature: signature});
	end
end

# var s3Uploader = (function () {
 
#     var signingURI = "/signing";
 
#     function upload(imageURI, fileName) {
 
#         var deferred = $.Deferred(),
#             ft = new FileTransfer(),
#             options = new FileUploadOptions();
 
#         options.fileKey = "file";
#         options.fileName = fileName;
#         options.mimeType = "image/jpeg";
#         options.chunkedMode = false;
 
#         $.ajax({url: signingURI, data: {"fileName": fileName}, dataType: "json", type: "POST"})
#             .done(function (data) {
#                 options.params = {
#                     "key": fileName,
#                     "AWSAccessKeyId": data.awsKey,
#                     "acl": "public-read",
#                     "policy": data.policy,
#                     "signature": data.signature,
#                     "Content-Type": "image/jpeg"
#                 };
 
#                 ft.upload(imageURI, "https://" + data.bucket + ".s3.amazonaws.com/",
#                     function (e) {
#                         deferred.resolve(e);
#                     },
#                     function (e) {
#                         alert("Upload failed");
#                         deferred.reject(e);
#                     }, options);
 
#             })
#             .fail(function (error) {
#                 console.log(JSON.stringify(error));
#             });
#              return deferred.promise();
 
#     }
 
#     return {
#         upload: upload
#     }
 
# }());
