
#pragma pack(push,1)
typedef struct _ezi_send
{
    unsigned char stx;
    unsigned char length;
    unsigned char sync;
    unsigned char reserved;
    unsigned char frametype;
} ezi_send_t;

typedef struct _ezi_servoen
{
    unsigned char stx;
    unsigned char length;
    unsigned char sync;
    unsigned char reserved;
    unsigned char frametype;
    unsigned char enable;
} ezi_servo_enable_t;


typedef struct _ezi_move
{
    unsigned char stx;
    unsigned char length;
    unsigned char sync;
    unsigned char reserved;
    unsigned char frametype;
    unsigned int position;
    unsigned int speed;
} ezi_move_t;

typedef struct _ezi_movevelocity
{
    unsigned char stx;
    unsigned char length;
    unsigned char sync;
    unsigned char reserved;
    unsigned char frametype;
    unsigned int speed;
    unsigned char direction;
} ezi_movevelocity_t;

typedef struct _ezi_veloverride
{
    unsigned char stx;
    unsigned char length;
    unsigned char sync;
    unsigned char reserved;
    unsigned char frametype;
    unsigned int speed;
} ezi_veloverride_t;


typedef struct _ezi_move2limit
{
    unsigned char stx;
    unsigned char length;
    unsigned char sync;
    unsigned char reserved;
    unsigned char frametype;
    unsigned int speed;
    unsigned char limit;
} ezi_move2limit_t;

typedef struct _ezi_movestop
{
    unsigned char stx;
    unsigned char length;
    unsigned char sync;
    unsigned char reserved;
    unsigned char frametype;    
} ezi_movestop_t;


typedef struct _ezi_recv
{
    unsigned char stx;
    unsigned char length;
    unsigned char sync;
    unsigned char reserved;
    unsigned char frametype;
    unsigned char status;
} ezi_recv_t;
#pragma pack(pop)
