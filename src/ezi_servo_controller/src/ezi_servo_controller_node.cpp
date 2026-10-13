// https://docs.microsoft.com/ko-kr/dotnet/framework/network-programming/asynchronous-server-socket-example
#include <ros/ros.h>
#include <ros/console.h>
#include <iostream>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <errno.h>
#include <netinet/in.h>
#include <arpa/inet.h>


#include "ezi_packet.h"
#include "ezi_frametype.h"

#include <std_msgs/Int32.h>
#include <std_msgs/Empty.h>
// 5.2 add
#include <std_msgs/Int32MultiArray.h>
#include <std_msgs/Bool.h>


extern int errno;
#define MAX 80
#define PORT 2002
#define SA struct sockaddr

int sockfd;
int ezi_sync=1;
// 5.2 add
bool driveState = true;
bool stopState = false;

int actualPos_ = 0;
int actualPos__ = 0;
ros::Publisher controlEziServoActualPosPub_;

int do_fas_getboardinfo()
{
    unsigned char recv_data[255];
    ezi_send_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    memset(&s,0x00,sizeof(ezi_send_t));
    memset(&recv_data,0x00,sizeof(recv_data));
    r=(ezi_recv_t *)recv_data;
    s.stx=0xAA;
    s.length=3;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_GetboardInfo;

    sb=send(sockfd,&s,5,0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        }
    }
    return ret;
}

int do_fas_getax()
{
    unsigned char recv_data[255];
    ezi_send_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int i;

    int axisstatus=0;
    memset(&s,0x00,sizeof(ezi_send_t));
    memset(&recv_data,0x00,sizeof(recv_data));
    r=(ezi_recv_t *)recv_data;
    s.stx=0xAA;
    s.length=3;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_GetAxisStatus;

    sb=send(sockfd,&s,5,0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        axisstatus=recv_data[sizeof(ezi_recv_t)];

	for (i=0;i<rb;i++)
	{
		printf("%02x\n",recv_data[i]);
	}

        printf("axisstatus = %08x: %s:%d\n",axisstatus,__func__,__LINE__);
        if (axisstatus&FFLAG_ERRORALL)
        {
                printf("ERROR : FFLAG_ERRORALL %s:%d\n",__func__,__LINE__);
        }
        if(axisstatus&FFLAG_SERVOON)
        {
                printf("FFLAG_SERVOON(enable) = %08x: %s:%d\n",axisstatus,__func__,__LINE__);
        }
        else
                printf("FFLAG_SERVOON(disable) = %08x: %s:%d\n",axisstatus,__func__,__LINE__);

        }
    }
    return ret;
}

int do_fas_servoalarmreset()
{
    unsigned char recv_data[255];
    ezi_send_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int i;
    int axisstatus=0;
    memset(&s,0x00,sizeof(ezi_send_t));
    memset(&recv_data,0x00,sizeof(recv_data));
    r=(ezi_recv_t *)recv_data;
    s.stx=0xAA;
    s.length=3;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_ServoAlarmReset;

    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
	    printf("OK : send %d byte\n",sb);
	    rb=read(sockfd,recv_data,sizeof(recv_data));
	    if (rb<0)
	    {
		    printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
	    }
	    else {
		    printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
				    rb,
				    r->stx,
				    r->length,
				    r->sync,
				    r->reserved,
				    r->frametype,
				    r->status);
		    switch (r->status)
		    {
			    case 0x00: printf("cmd ok\n"); ret=0; break;
			    case 0x80: printf("ERROR : wrong frametype\n"); break;
			    case 0x81: printf("ERROR : range over date\n"); break;
			    case 0x82: printf("ERROR : invalid frametype format\n"); break;
			    case 0x85: printf("ERROR : drive faild\n"); break;
			    case 0x86: printf("ERROR : reset failed\n"); break;
			    case 0x87: printf("ERROR : servo on fail(1)\n"); break;
			    case 0x88: printf("ERORR : servo on fail(2)\n"); break;
			    case 0x89: printf("ERROR : servo on fail(3)\n"); break;
			    default: printf("ERROR : status = %02x\n",r->status); break;
		    }
		    for (i=0;i<rb;i++)
		    {
			    printf("%02x\n",recv_data[i]);
		    }
	    }
    }
    return ret;
}


int do_fas_servoenable()
{
    unsigned char recv_data[255];
    ezi_servo_enable_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int i;
    int axisstatus=0;
    memset(&s,0x00,sizeof(ezi_servo_enable_t));
    memset(&recv_data,0x00,sizeof(recv_data));
    r=(ezi_recv_t *)recv_data;
    s.stx=0xAA;
    s.length=4;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_ServoEnable;
    s.enable=1;

    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
	    printf("OK : send %d byte\n",sb);
	    rb=read(sockfd,recv_data,sizeof(recv_data));
	    if (rb<0)
	    {
		    printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
	    }
	    else {
		    printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
				    rb,
				    r->stx,
				    r->length,
				    r->sync,
				    r->reserved,
				    r->frametype,
				    r->status);
		    switch (r->status)
		    {
			    case 0x00: printf("cmd ok\n"); ret=0; break;
			    case 0x80: printf("ERROR : wrong frametype\n"); break;
			    case 0x81: printf("ERROR : range over date\n"); break;
			    case 0x82: printf("ERROR : invalid frametype format\n"); break;
			    case 0x85: printf("ERROR : drive faild\n"); break;
			    case 0x86: printf("ERROR : reset failed\n"); break;
			    case 0x87: printf("ERROR : servo on fail(1)\n"); break;
			    case 0x88: printf("ERORR : servo on fail(2)\n"); break;
			    case 0x89: printf("ERROR : servo on fail(3)\n"); break;
			    default: printf("ERROR : status = %02x\n",r->status); break;
		    }
		    for (i=0;i<rb;i++)
		    {
			    printf("%02x\n",recv_data[i]);
		    }
	    }
    }
    return ret;
}


int do_fas_movesingle(int degree)
{
    unsigned char recv_data[255];
    ezi_move_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int axisstatus=0;

    memset(&s,0x00,sizeof(ezi_move_t));

    s.stx=0xAA;
    s.length=3+4+4;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_MoveSingleAxisAbsPos;

    s.speed=10000;
    //int max=815500;
    //int max=655350;
    int max=140000;
    s.position=(max*(degree-27))/360;
    
//    s.position=407750;
    printf("-----------> position = %d\n",s.position);
    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
    	memset(&recv_data,0x00,sizeof(recv_data));
    	r=(ezi_recv_t *)recv_data;

        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        }
    }
    return ret;
}

// 4.28 add

int do_fas_movesingle_inc(int degree)
{
    unsigned char recv_data[255];
    ezi_move_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int axisstatus=0;

    memset(&s,0x00,sizeof(ezi_move_t));

    s.stx=0xAA;
    s.length=3+4+4;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_MoveSingleAxisIncPos;

    s.speed=10000;
    //int max=815500;
    //int max=655350;
    int max=140000;
    // s.position=(max*(degree-27))/360;

    if (degree > 360)
    {
        s.position = (max*(degree-360))/360*(-1);
    }
    else
    {
        s.position=(max*(degree))/360;
    }
    
    
//    s.position=407750;
    printf("-----------> position = %d\n",s.position);
    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
    	memset(&recv_data,0x00,sizeof(recv_data));
    	r=(ezi_recv_t *)recv_data;

        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        }
    }
    return ret;
}


// 4.28 add
int do_fas_velocityoverride(int speed)
{
    unsigned char recv_data[255];
    ezi_veloverride_t s; // 5.2 modify
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int axisstatus=0;

    memset(&s,0x00,sizeof(ezi_veloverride_t));

    s.stx=0xAA;
    s.length=3+4;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_VelocityOverride;

    s.speed=speed;
    
    printf("-----------> speed = %d\n",s.speed);
    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
    	memset(&recv_data,0x00,sizeof(recv_data));
    	r=(ezi_recv_t *)recv_data;

        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        }
    }
    return ret;
}


int do_fas_movevelocity(char direction)
{
    unsigned char recv_data[255];
    ezi_movevelocity_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int axisstatus=0;

    // memset(&s,0x00,sizeof(ezi_move_t));
    memset(&s,0x00,sizeof(ezi_movevelocity_t));

    s.stx=0xAA;
    s.length=3+4+1;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_MoveVelocity;

    s.speed=10000;
    s.direction=direction;
    
//    s.position=407750;
    printf("-----------> direction = %d , speed = %d \n", s.direction, s.speed);
    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
    	memset(&recv_data,0x00,sizeof(recv_data));
    	r=(ezi_recv_t *)recv_data;

        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        }
    }
    return ret;
}

// 4.28 add
int do_fas_movevelocity_(const std_msgs::Int32MultiArray & msg) // 5.2 modify
{
    unsigned char recv_data[255];
    ezi_movevelocity_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int axisstatus=0;

    memset(&s,0x00,sizeof(ezi_movevelocity_t));

    s.stx=0xAA;
    s.length=3+4+1;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_MoveVelocity;

    // s.speed=5000;
    // s.direction=direction;
    s.speed=msg.data[1];
    s.direction=msg.data[0];
    
//    s.position=407750;
    printf("-----------> direction = %d , speed = %d \n", s.direction, s.speed);
    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
    	memset(&recv_data,0x00,sizeof(recv_data));
    	r=(ezi_recv_t *)recv_data;

        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85:
                {
                    printf("ERROR : drive faild\n");
                    ret = -2;
                    break;
                }
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        }
    }
    return ret;
}

int do_fas_movestop(){
    unsigned char recv_data[255];
    ezi_movestop_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int axisstatus=0;

    // memset(&s,0x00,sizeof(ezi_move_t));
    memset(&s,0x00,sizeof(ezi_movestop_t));

    s.stx=0xAA;
    s.length=3;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_MoveStop;

    
//    s.position=407750;
    printf("-----------> stop \n");
    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
    	memset(&recv_data,0x00,sizeof(recv_data));
    	r=(ezi_recv_t *)recv_data;

        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        }
    }
    return ret;
}

int do_fas_originsingle()
{
    unsigned char recv_data[255];
    ezi_send_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int axisstatus=0;
    memset(&s,0x00,sizeof(ezi_send_t));
    memset(&recv_data,0x00,sizeof(recv_data));
    r=(ezi_recv_t *)recv_data;
    s.stx=0xAA;
    s.length=3;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_MoveOriginSingleAxis;

    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
	    }
    }
    return ret;
}

int do_fas_movetolimit()
{
    unsigned char recv_data[255];
    ezi_move2limit_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;

    int axisstatus=0;
    memset(&s,0x00,sizeof(ezi_move2limit_t));
    memset(&recv_data,0x00,sizeof(recv_data));
    r=(ezi_recv_t *)recv_data;
    s.stx=0xAA;
    s.length=3+4+1;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_MoveToLimit;
    s.speed=0x0000ffff;
    s.limit=1;

    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        // axisstatus = ( ezi_recv_t * )( recv + 1 );
        // printf("axisstatus = %08x: %s:%d\n",axisstatus,__func__,__LINE__);
        // if (axisstatus&FFLAG_ERRORALL)
        // {
		// 	printf("ERROR : FFLAG_ERRORALL %s:%d\n",__func__,__LINE__);
        // }
        // if(axisstatus&FFLAG_SERVOON)
        // {
		// 	printf("FFLAG_SERVOON(enable) = %08x: %s:%d\n",axisstatus,__func__,__LINE__);
        // }
        // else
		// 	printf("FFLAG_SERVOON(disable) = %08x: %s:%d\n",axisstatus,__func__,__LINE__);

        }
    }
    return ret;
}

int do_fas_getactualpos(){
    unsigned char recv_data[255];
    // unsigned char recv_data[5];
    // ezi_move2limit_t s;
    ezi_send_t s;
    ezi_recv_t *r;
    int ret=-1;
    int rb=0;
    int sb=0;
    
    int pos=0;

    memset(&s,0x00,sizeof(ezi_send_t));
    memset(&recv_data,0x00,sizeof(recv_data));
    r=(ezi_recv_t *)recv_data;
    s.stx=0xAA;
    s.length=3;
    s.sync=ezi_sync++;
    s.reserved=0x00;
    s.frametype=FAS_GetActualPos;

    sb=send(sockfd,&s,sizeof(s),0);
    if (sb<0)
    {
        printf("ERROR : send %s:%d [%s]\n",__func__,__LINE__,strerror(errno));
    }
    else
    {
        printf("OK : send %d byte\n",sb);
        rb=read(sockfd,recv_data,sizeof(recv_data));
        if (rb<0)
        {
            printf("ERROR : recv[%d] %s:%d\n",rb,__func__,__LINE__);
        }
        else {
            printf("OK : recv[%d] %02x,%02x,%02x,%02x,%02x,%02x\n",
                    rb,
                    r->stx,
                    r->length,
                    r->sync,
                    r->reserved,
                    r->frametype,
                    r->status);
            switch (r->status)
            {
                case 0x00: printf("cmd ok\n"); ret=0; break;
                case 0x80: printf("ERROR : wrong frametype\n"); break;
                case 0x81: printf("ERROR : range over date\n"); break;
                case 0x82: printf("ERROR : invalid frametype format\n"); break;
                case 0x85: printf("ERROR : drive faild\n"); break;
                case 0x86: printf("ERROR : reset failed\n"); break;
                case 0x87: printf("ERROR : servo on fail(1)\n"); break;
                case 0x88: printf("ERORR : servo on fail(2)\n"); break;
                case 0x89: printf("ERROR : servo on fail(3)\n"); break;
                default: printf("ERROR : status = %02x\n",r->status); break;
            }
        // actualPos_ = recv_data[sizeof(ezi_recv_t)];;

            if (ret == 0 && rb >= 5) {
                // actualPos_ = (recv_data[6] << 24) | (recv_data[7] << 16) | (recv_data[8] << 8) | recv_data[9];
                actualPos__ = recv_data[6] | (recv_data[7] << 8) | (recv_data[8] << 16) | (recv_data[9] << 24);
                // printf("Actual Position = %d\n", actualPos_);
                printf("Actual_ Position = %d\n", actualPos__);
            } else {
                printf("ERROR: Insufficient data received or command failed.\n");
            }

            for (int i = 0; i < rb; i++) {
                printf("recv_data[%d] = %02x\n", i, recv_data[i]);
            }
        // printf("axisstatus = %08x: %s:%d\n",axisstatus,__func__,__LINE__);
        // if (axisstatus&FFLAG_ERRORALL)
        // {
		// 	printf("ERROR : FFLAG_ERRORALL %s:%d\n",__func__,__LINE__);
        // }
        // if(axisstatus&FFLAG_SERVOON)
        // {
		// 	printf("FFLAG_SERVOON(enable) = %08x: %s:%d\n",axisstatus,__func__,__LINE__);
        // }
        // else
		// 	printf("FFLAG_SERVOON(disable) = %08x: %s:%d\n",axisstatus,__func__,__LINE__);

        }
    }
    return ret;
}

// 8.5

int move_to_near_angle(int target_degree) {
    int current_position = 0;
    int target_position = 0;
    int max_position = 140000;
    int min_degree = 27;      
    int max_degree = 360;

    if (do_fas_getactualpos() != 0) {
        printf("ERROR: Failed to get current position.\n");
        return -1;
    }

    current_position = actualPos__;

    target_position = (max_position * (target_degree - min_degree)) / max_degree;

    printf("Current Position: %d, Target Position: %d\n", current_position, target_position);


    int delta_position = target_position - current_position;

    int iteration_count = 0;
    const int max_iterations = 10; 

    while (abs(delta_position) > max_position / 2 && iteration_count < max_iterations) {
        if (delta_position > max_position / 2) {
            delta_position -= max_position;
        } else if (delta_position < -max_position / 2) {
            delta_position += max_position;
        }
        iteration_count++;
    }


    int final_position = current_position + delta_position;

    int final_degree = (final_position * max_degree) / max_position + min_degree;

    printf("Moving to optimized degree: %d\n", final_degree);


    if (do_fas_movesingle(final_degree) != 0) {
        printf("ERROR: Failed to move to final position.\n");
        return -1;
    }

    return 0;
}


void controlEziServoCallback(const std_msgs::Int32 & msg){
	
	if (msg.data == -1){
		printf("origin single\n");
	    do_fas_originsingle();
	}
	else {
		std::cout << "move single to " << msg.data << std::endl;
		do_fas_movesingle(msg.data);
	}
}

// 8.5 add
void controlEziServoNearCallback(const std_msgs::Int32 & msg){
	
	if (msg.data == -1){
		printf("origin single\n");
	    do_fas_originsingle();
	}
	else {
		std::cout << "move single to " << msg.data << std::endl;
		move_to_near_angle(msg.data);
	}
}

// 4.28 add
void controlEziServoIncCallback(const std_msgs::Int32 & msg){
	
    std::cout << "move single to " << msg.data << std::endl;
    do_fas_movesingle_inc(msg.data);

}

// 4.28 add
void controlEziServoVelOverCallback(const std_msgs::Int32 & msg){
	
    std::cout << "velocity override to " << msg.data << std::endl;
    do_fas_velocityoverride(msg.data);

}



void controlEziServoJogCallback(const std_msgs::Int32 & msg){
    do_fas_movevelocity(msg.data);
}

// 4.28 add
void controlEziServoJogCallback_(const std_msgs::Int32MultiArray & msg){ // 5.2 modify
    int ret_ = -1;
    ret_ = do_fas_movevelocity_(msg); // 5.2 modify
    if (ret_ == -2){
        driveState = false;
    }
}   

void controlEziServoStopCallback(const std_msgs::Empty & msg){
    int ret_stop = -1;
    ret_stop = do_fas_movestop();
    if (ret_stop == 0){
        stopState = true;
    }
}

void requestEziServoActualPosCallback(const std_msgs::Empty & msg){
    do_fas_getactualpos();
    std_msgs::Int32 actualPosMsg;
    actualPosMsg.data = actualPos_;
    controlEziServoActualPosPub_.publish(actualPosMsg);
}


int main (int argc, char** argv)
{
	ros::init(argc, argv, "ezi_servo_controller");
    ros::NodeHandle nh;
    ros::Rate loop_rate(10);

	ros::Subscriber controlEziServoSubscriber = nh.subscribe("/control_ezi_servo", 10, controlEziServoCallback);
    ros::Subscriber controlEziServoIncSubscriber = nh.subscribe("/control_ezi_servo_inc", 10, controlEziServoIncCallback);     // 4.28 add
    ros::Subscriber controlEziServoVelOverSubscriber = nh.subscribe("/control_ezi_servo_velover", 10, controlEziServoVelOverCallback);     // 4.28 add
    ros::Subscriber controlEziServoJogSubscriber = nh.subscribe("/control_ezi_servo_jog", 10, controlEziServoJogCallback);
    ros::Subscriber controlEziServoJogSubscriber_ = nh.subscribe("/control_ezi_servo_jog_", 10, controlEziServoJogCallback_); // 4.28 add
    ros::Subscriber controlEziServoStopSubscriber = nh.subscribe("/control_ezi_servo_stop", 10, controlEziServoStopCallback);
    ros::Subscriber requestEziServoActualPosSubscriber = nh.subscribe("/request_ezi_servo_actual_pos", 1, requestEziServoActualPosCallback);
    ros::Subscriber controlEziServoNearSubscriber = nh.subscribe("/control_ezi_servo_near", 10, controlEziServoNearCallback); // 8.5 add

    ros::Publisher controlEziServoDrivePub = nh.advertise<std_msgs::Bool>("/control_ezi_drive_state", 2);
    ros::Publisher controlEziServoStopPub = nh.advertise<std_msgs::Bool>("/control_ezi_stop_state", 2);
    controlEziServoActualPosPub_ = nh.advertise<std_msgs::Int32>("/control_ezi_servo_actual_pos", 1);
	
	struct sockaddr_in servaddr, cli;

    // socket create and verification
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd == -1) {
        printf("socket creation failed...\n");
        exit(0);
    }
    else {
        printf("Socket successfully created..\n");
    }

    bzero(&servaddr, sizeof(servaddr));

    // assign IP, PORT
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = inet_addr("192.168.10.9");
    servaddr.sin_port = htons(PORT);

    // connect the client socket to server socket
    if (connect(sockfd, (SA*)&servaddr, sizeof(servaddr)) != 0) {
        printf("connection with the server failed...\n");
        exit(0);
    }
    else
        printf("connect OK\n");

    //do_fas_getboardinfo();
    sleep(1);
    do_fas_getax();
    printf("servoalarmreset\n");
    do_fas_servoalarmreset();

    printf("servoenable\n");
    do_fas_servoenable();
    sleep(1);
    
    do_fas_originsingle();
    sleep(1);

    sleep(15);
    do_fas_movesingle(-151);
	
	while(ros::ok())
    {
        if (driveState == false){
            std_msgs::Bool drivemsg;
            drivemsg.data = false;
            controlEziServoDrivePub.publish(drivemsg);
            driveState = true;
        }

        if (stopState == true){
            std_msgs::Bool stopmsg;
            stopmsg.data = true;
            controlEziServoStopPub.publish(stopmsg);
            stopState = false;
        }

        
		ros::spinOnce();

        loop_rate.sleep();
    }

	close(sockfd);
}

	
