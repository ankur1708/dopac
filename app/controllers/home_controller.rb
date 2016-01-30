class HomeController < ApplicationController

	# def signing
	# 	bucket = "YOUR_BUCKET_NAME",
 #    	awsKey = "YOUR_AWS_USER_KEY",
 #    	secret = "YOUR_AWS_USER_SECRET";

	#     var fileName = req.body.fileName,
	#     expiration = new Date(new Date().getTime() + 1000 * 60 * 5).toISOString();
	 
	#     var policy =
	#     { "expiration": expiration,
	#         "conditions": [
	#             {"bucket": bucket},
	#             {"key": fileName},
	#             {"acl": 'public-read'},
	#             ["starts-with", "$Content-Type", ""],
	#             ["content-length-range", 0, 524288000]
	#         ]};
	 
	#     policyBase64 = new Buffer(JSON.stringify(policy), 'utf8').toString('base64');
	#     signature = crypto.createHmac('sha1', secret).update(policyBase64).digest('base64');
	#     res.json({bucket: bucket, awsKey: awsKey, policy: policyBase64, signature: signature});
	# end
	 # create the document in rails, then send json back to our javascript to populate the form that will be
	  # going to amazon.
	  def signing
	    @document = Document.create(params[:doc])
	    render :json => {
	      :policy => s3_upload_policy_document, 
	      :signature => s3_upload_signature, 
	      :key => @document.s3_key, 
	      :success_action_redirect => document_upload_success_document_url(@document)
	    }
	  end


	 # generate the policy document that amazon is expecting.
	  def s3_upload_policy_document
	    return @policy if @policy
	    ret = {"expiration" => 5.minutes.from_now.utc.xmlschema,
	      "conditions" =>  [ 
	        {"bucket" =>  YOUR_BUCKET_NAME}, 
	        ["starts-with", "$key", @document.s3_key],
	        {"acl" => "private"},
	        {"success_action_status" => "200"},
	        ["content-length-range", 0, 1048576]
	      ]
	    }
	    @policy = Base64.encode64(ret.to_json).gsub(/\n/,'')
	  end

	  # sign our request by Base64 encoding the policy document.
	  def s3_upload_signature
	    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), YOUR_SECRET_KEY, s3_upload_policy_document)).gsub("\n","")
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
