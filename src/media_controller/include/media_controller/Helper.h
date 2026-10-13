#ifndef Helper_H
#define Helper_H

/**
 * @author Sanghwa Han
 */

namespace Helper
{
    enum RequestStatus
    {
        READY = 0,
        AD_MEDIA_PLAYING = 1,
		INTEGRIT_AD = 5,
        REQUESTED_AD_MEDIA_PLAYING = 10,
        REQUESTED_PREVENTION_PLAYING = 11,
        REQUESTED_NO_MASK_PLAYING = 12,
		CHARGING = 100,
		COMMUNICATION = 101
    };

    enum MediaStatus
    {
        REQUESTED_MEDIA_FINISHED = 0,
        REQUESTED_MEDIA_PLAYING = 1
    };
}

#endif // Helper.h
