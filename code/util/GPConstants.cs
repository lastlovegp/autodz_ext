using System;
using System.Runtime.InteropServices;
using System.Drawing;

namespace MdTZ
{
    public class GPConstants
    {
        //s_sh000001,s_sz399001,s_sz399006
        public const string SH_CODE = "sh000001";
        public const string SZ_CODE = "sz399001";
        public const string CYB_CODE = "sz399006";
        public const string DP_ALL_CODES = "sh000001,sz399001,sz399006";

        public const int TRAN_MODE_NORMAR = 0; // ��ͨ������)ģʽ
        public const int TRAN_MODE_RISK = 1; // ����ģʽ
        public const int TRAN_MODE_SUPER = 2; // ����ģʽ
        public const int TRAN_MODE_UN_TRAN = 9; //������

        public const int STRATEGY_MODE_NORMAR_PRD = 2; //����
        public const int STRATEGY_MODE_NORMAR_MN = 3; // ģ��
        public const int STRATEGY_MODE_NORMAR_HC= 4; // �ز�  

        public const int EVENT_REFSH_YW= 0; // ˢ������
        public const int EVENT_BUY_TRANS = 1; //�����¼�   
        public const int EVENT_SELL_TRANS = 2; //�����¼�    	


        public const int XH_BUY_UN_JC= -100; //��ͻ��

        public const int XH_BUY_JCMR = 1; //�������
        public const int XH_BUY_ZDCD_10 = 2; //10�µͳ���
        public const int XH_BUY_GKJJ = 3; //�߿�׷��
        public const int XH_BUY_SSZJ = 4; //����׷��  
        public const int XH_BUY_QSHT = 25; //ǿ�ƹɻص�
        public const int XH_BUY_ZDCD_5 = 29; //5���µͷ���
        public const int XH_BUY_ZDCD_20 = 7; //20�µͳ���
        public const int XH_BUY_DEDD = 8; //�ڶ��ص�     
        public const int XH_BUY_ALL_SEL = 9;//ȫ��ѡ��
        public const int XH_BUY_CD = 20;//�����Ƿ�����������
        public const int XH_BUY_CD_1 = 21;//�ɽ�������
        public const int XH_BUY_CD_2= 22; //ǿ�ƹɻص�
        public const int XH_BUY_CD_3 = 23; //���̵�λ�߿�
        public const int XH_BUY_TL = 24; //����
        public const int XH_BUY_TL_EXT = 27; //���� 2
        public const int XH_BUY_HP_QD = 16; //��������
        public const int XH_BUY_TP_TOP_20 = 17; //ͻ��ǰ20�����
        public const int XH_BUY_TP_JX = 28; //ͻ������
        public const int XH_BUY_CJL_ZD = 99; //�ɽ������

        public const int XH_BUY_LZ_TWO_DAYS = 20; //��������
        public const int XH_BUY_DK_LAHONG = 22; //�Ϳ�����
        public const int XH_BUY_TP_XP = 35; //ͻ��ϴ��
        public const int XH_BUY_LD_2DAY_FD = 40; //��������󷴵�

        public const int XH_BUY_ZT_GSD = 30; //��ͣ������
        public const int XH_BUY_ZT_ECFT = 31; //���η���
        public const int XH_BUY_ZT_ZJ = 32; //��ͣ��׷��
        public const int XH_BUY_THREE_SZ = 33; //����3��
        public const int XH_BUY_FRIST_ZJ = 34; //����׷��

        public const int XH_SELL_DBXD = -5; //�����µ�
        public const int XH_SELL_SCMC = -6; //�����µ�

        public const int CZFX_ZC = 1; //������
        public const int CZFX_YC = 0; //�Ҳ����

        public const String STR_SEL_GPS = "Strategy_Sel_Gps"; //ѡ����
        public const String STR_TAOLI = "Strategy_Taoli"; //����
        public const String STR_JCMR = "Strategy_JCMR"; //�������
        public const String STR_SUPER_MAN = "Strategy_Superman"; //ǿ��ָ������

    }

}
