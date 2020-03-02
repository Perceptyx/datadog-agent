--- rtloader/common/rtloader_mem.h.orig	2019-12-17 19:31:02 UTC
+++ rtloader/common/rtloader_mem.h
@@ -69,6 +69,8 @@ void _free(void *ptr);
 #        define __THROW
 #    elif __APPLE__
 #        define __THROW
+#    elif __FreeBSD__
+#        define __THROW
 #    endif
 
 char *strdupe(const char *s1) __THROW;
