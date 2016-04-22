# Sun 15:35 Apr 03

OS = $(shell uname -s)

ifeq ($(OS), Darwin)
LIBFLAG = -Wl,-undefined,dynamic_lookup
EXPORT =
EXTRA_LIB =
else
LIBFLAG = -shared
EXPORT = -Wl,-E
EXTRA_LIB = -lrt
endif

CC = clang
AR = ar rcu
RANLIB = ranlib
RM = rm -f

CFLAGS = -fPIC -g -Wall -I. -DLIQUIDFUN_EXTERNAL_LANGUAGE_API=1

all : libliquidfun.a

BOX2DLIB_C = $(wildcard Box2D/*/*.cpp)
BOX2DLIB_C += $(wildcard Box2D/*/*/*.cpp)

BOX2DLIB_M = $(patsubst %.cpp, %, $(BOX2DLIB_C))
BOX2DLIB_O = $(patsubst %, %.o, $(BOX2DLIB_M))

define COMPILE_LIQUIDFUN
$(1).o : $(1).cpp
	$(CC) $(CFLAGS) -o $$@ -c $$<
endef
$(foreach v, $(BOX2DLIB_M), $(eval $(call COMPILE_LIQUIDFUN, $(v))))

libliquidfun.a : $(BOX2DLIB_O)
	@$(AR) $@ $^
	@$(RANLIB) $@

clean :
	$(RM) libliquidfun.a

cleanall :
	$(RM) libliquidfun.a $(BOX2DLIB_O)

.PHONY: all clean cleanall
