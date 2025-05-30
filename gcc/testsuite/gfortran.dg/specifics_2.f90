! { dg-do compile }
  ! This is the list of intrinsics allowed as actual arguments
  implicit none
 intrinsic abs,acos,acosh,aimag,aint,alog,alog10,amod,anint,asin,asinh,atan,&
 atan2,atanh,cabs,ccos,cexp,clog,conjg,cos,cosh,csin,csqrt,dabs,dacos,&
 dacosh,dasin,dasinh,datan,datan2,datanh,dconjg,dcos,dcosh,ddim,dexp,dim,&
 dimag,dint,dlog,dlog10,dmod,dnint,dprod,dsign,dsin,dsinh,dsqrt,dtan,dtanh,&
 exp,iabs,idim,idnint,index,isign,len,mod,nint,sign,sin,sinh,sqrt,tan,&
 tanh,zabs,zcos,zexp,zlog,zsin,zsqrt
 
  call foo_r4(abs)
  call foo_r4(acos)
  call foo_r4(acosh)
  call foo_r4(aimag)
  call foo_r4(aint)
  call foo_r4(alog)
  call foo_r4(alog10)
  call foo_r4(amod)
  call foo_r4(anint)
  call foo_r4(asin)
  call foo_r4(asinh)
  call foo_r4(atan)
  call foo_r4(atan2)
  call foo_r4(atanh)
  call foo_r4(cabs)
  call foo_c4(ccos)
  call foo_c4(cexp)
  call foo_c4(clog)
  call foo_c4(conjg)
  call foo_r4(cos)
  call foo_r4(cosh)
  call foo_c4(csin)
  call foo_c4(csqrt)
  call foo_r8(dabs)
  call foo_r8(dacos)
  call foo_r8(dacosh)
  call foo_r8(dasin)
  call foo_r8(dasinh)
  call foo_r8(datan)
  call foo_r8(datan2)
  call foo_r8(datanh)
  call foo_c8(dconjg)
  call foo_r8(dcos)
  call foo_r8(dcosh)
  call foo_r8(ddim)
  call foo_r8(dexp)
  call foo_r8(ddim)
  call foo_r8(dimag)
  call foo_r8(dint)
  call foo_r8(dlog)
  call foo_r8(dlog10)
  call foo_r8(dmod)
  call foo_r8(dnint)
  call foo_r8(dprod)
  call foo_r8(dsign)
  call foo_r8(dsin)
  call foo_r8(dsinh)
  call foo_r8(dsqrt)
  call foo_r8(dtan)
  call foo_r8(dtanh)
  call foo_r5(exp)
  call foo_i4(iabs)
  call foo_i4(idim)
  call foo_i4(idnint)
  call foo_i4(index)
  call foo_i4(isign)
  call foo_i4(len)
  call foo_i4(mod)
  call foo_i4(nint)
  call foo_r4(sign)
  call foo_r4(sin)
  call foo_r4(sinh)
  call foo_r4(sqrt)
  call foo_r4(tan)
  call foo_r4(tanh)
  call foo_r8(zabs)
  call foo_c8(zcos)
  call foo_c8(zexp)
  call foo_c8(zlog)
  call foo_c8(zsin)
  call foo_c8(zsqrt)
  end
