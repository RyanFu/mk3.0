//
 (id)DES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)akey;
 (NSString *)HMACMD5WithKey:(NSString *)akey andData:(NSString *)data;
 (id)rsaEncryptString:(NSString*) string;
 (NSString *)getIPAddress:(BOOL)preferIPv4;