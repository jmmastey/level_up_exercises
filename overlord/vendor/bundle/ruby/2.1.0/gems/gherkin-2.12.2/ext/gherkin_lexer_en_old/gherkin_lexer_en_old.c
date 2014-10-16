
#line 1 "ragel/i18n/en_old.c.rl"
#include <assert.h>
#include <ruby.h>

#if defined(_WIN32)
#include <stddef.h>
#endif

#ifdef HAVE_RUBY_RE_H
#include <ruby/re.h>
#else
#include <re.h>
#endif

#ifdef HAVE_RUBY_ENCODING_H
#include <ruby/encoding.h>
#define ENCODED_STR_NEW(ptr, len) \
    rb_enc_str_new(ptr, len, rb_utf8_encoding())
#else
#define ENCODED_STR_NEW(ptr, len) \
    rb_str_new(ptr, len)
#endif

#ifndef RSTRING_PTR
#define RSTRING_PTR(s) (RSTRING(s)->ptr)
#endif

#ifndef RSTRING_LEN
#define RSTRING_LEN(s) (RSTRING(s)->len)
#endif

#define DATA_GET(FROM, TYPE, NAME) \
  Data_Get_Struct(FROM, TYPE, NAME); \
  if (NAME == NULL) { \
    rb_raise(rb_eArgError, "NULL found for " # NAME " when it shouldn't be."); \
  }
 
typedef struct lexer_state {
  int content_len;
  int line_number;
  int current_line;
  int start_col;
  size_t mark;
  size_t keyword_start;
  size_t keyword_end;
  size_t next_keyword_start;
  size_t content_start;
  size_t content_end;
  size_t docstring_content_type_start;
  size_t docstring_content_type_end;
  size_t query_start;
  size_t last_newline;
  size_t final_newline;
} lexer_state;

static VALUE mGherkin;
static VALUE mGherkinLexer;
static VALUE mCLexer;
static VALUE cI18nLexer;
static VALUE rb_eGherkinLexingError;

#define LEN(AT, P) (P - data - lexer->AT)
#define MARK(M, P) (lexer->M = (P) - data)
#define PTR_TO(P) (data + lexer->P)

#define STORE_KW_END_CON(EVENT) \
  store_multiline_kw_con(listener, # EVENT, \
    PTR_TO(keyword_start), LEN(keyword_start, PTR_TO(keyword_end - 1)), \
    PTR_TO(content_start), LEN(content_start, PTR_TO(content_end)), \
    lexer->current_line, lexer->start_col); \
    if (lexer->content_end != 0) { \
      p = PTR_TO(content_end - 1); \
    } \
    lexer->content_end = 0

#define STORE_ATTR(ATTR) \
    store_attr(listener, # ATTR, \
      PTR_TO(content_start), LEN(content_start, p), \
      lexer->line_number)


#line 254 "ragel/i18n/en_old.c.rl"


/** Data **/

#line 89 "ext/gherkin_lexer_en_old/gherkin_lexer_en_old.c"
static const char _lexer_actions[] = {
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 4, 1, 5, 1, 6, 1, 
	7, 1, 8, 1, 9, 1, 10, 1, 
	11, 1, 12, 1, 13, 1, 16, 1, 
	17, 1, 18, 1, 19, 1, 20, 1, 
	21, 1, 22, 1, 23, 2, 1, 18, 
	2, 4, 5, 2, 13, 0, 2, 14, 
	15, 2, 17, 0, 2, 17, 2, 2, 
	17, 16, 2, 17, 19, 2, 18, 6, 
	2, 18, 7, 2, 18, 8, 2, 18, 
	9, 2, 18, 10, 2, 18, 16, 2, 
	20, 21, 2, 22, 0, 2, 22, 2, 
	2, 22, 16, 2, 22, 19, 3, 3, 
	14, 15, 3, 5, 14, 15, 3, 11, 
	14, 15, 3, 12, 14, 15, 3, 13, 
	14, 15, 3, 14, 15, 18, 3, 17, 
	0, 11, 3, 17, 14, 15, 4, 1, 
	14, 15, 18, 4, 4, 5, 14, 15, 
	4, 17, 0, 14, 15, 5, 17, 0, 
	11, 14, 15
};

static const short _lexer_key_offsets[] = {
	0, 0, 18, 21, 22, 23, 24, 25, 
	40, 43, 46, 48, 65, 69, 71, 72, 
	75, 77, 94, 95, 96, 98, 100, 105, 
	110, 115, 120, 124, 128, 130, 131, 132, 
	133, 134, 135, 136, 137, 138, 139, 140, 
	141, 142, 143, 144, 145, 146, 148, 153, 
	160, 165, 167, 168, 170, 171, 172, 173, 
	174, 175, 186, 188, 190, 192, 209, 210, 
	211, 213, 214, 216, 218, 219, 220, 221, 
	222, 229, 231, 234, 236, 238, 240, 242, 
	243, 244, 246, 247, 248, 250, 251, 252, 
	253, 254, 255, 256, 257, 258, 259, 274, 
	277, 280, 282, 299, 303, 305, 306, 309, 
	312, 315, 318, 319, 320, 321, 322, 323, 
	325, 326, 329, 332, 336, 342, 345, 347, 
	353, 370, 372, 374, 376, 379, 381, 398, 
	402, 404, 406, 408, 410, 412, 414, 416, 
	418, 420, 422, 424, 426, 428, 430, 432, 
	434, 437, 439, 441, 443, 445, 447, 449, 
	451, 453, 455, 458, 460, 478, 479, 480, 
	481, 482, 497, 501, 503, 505, 508, 510, 
	527, 531, 532, 533, 535, 537, 539, 542, 
	544, 561, 565, 567, 569, 571, 573, 575, 
	577, 579, 581, 583, 585, 587, 589, 591, 
	593, 596, 598, 601, 603, 605, 607, 609, 
	611, 613, 615, 618, 620, 622, 625, 627, 
	629, 631, 633, 635, 637, 639, 641, 644, 
	646, 664, 665, 667, 669, 671, 673, 675, 
	677, 679, 681, 683, 685, 687, 689, 691, 
	693, 695, 697, 700, 702, 704, 706, 709, 
	711, 714, 717, 719, 721, 723, 726, 728, 
	730, 733, 735, 737, 739, 741, 743, 745, 
	747, 748, 751, 752, 753, 755, 757, 759, 
	762, 764, 781, 785, 787, 789, 791, 793, 
	795, 797, 799, 801, 803, 805, 807, 809, 
	811, 813, 815, 817, 820, 822, 824, 826, 
	828, 830, 832, 834, 836, 839, 841, 843, 
	846, 848, 850, 852, 854, 856, 858, 860, 
	862, 865, 867, 885, 886, 887, 888
};

static const char _lexer_trans_keys[] = {
	-61, -17, 10, 32, 34, 35, 37, 42, 
	55, 64, 65, 72, 79, 83, 84, 124, 
	9, 13, -122, -112, -98, 114, 58, 10, 
	10, -61, 10, 32, 35, 37, 42, 55, 
	64, 65, 72, 79, 83, 84, 9, 13, 
	-112, -98, 10, 10, 97, 117, 10, 32, 
	-61, 10, 32, 34, 35, 37, 42, 55, 
	64, 65, 72, 79, 83, 84, 124, 9, 
	13, -122, -112, -98, -80, 97, 117, 32, 
	-61, 10, 13, 10, 13, -61, 10, 32, 
	34, 35, 37, 42, 55, 64, 65, 72, 
	79, 83, 84, 124, 9, 13, 34, 34, 
	10, 13, 10, 13, 10, 32, 34, 9, 
	13, 10, 32, 34, 9, 13, 10, 32, 
	34, 9, 13, 10, 32, 34, 9, 13, 
	10, 32, 9, 13, 10, 32, 9, 13, 
	10, 13, 10, 95, 70, 69, 65, 84, 
	85, 82, 69, 95, 69, 78, 68, 95, 
	37, 32, 10, 13, 13, 32, 64, 9, 
	10, 9, 10, 13, 32, 64, 11, 12, 
	10, 32, 64, 9, 13, 99, 101, 119, 
	-61, 97, -90, 116, 58, 10, 10, -61, 
	10, 32, 35, 37, 64, 65, 72, 83, 
	9, 13, -122, 10, 10, 114, 10, 58, 
	-61, 10, 32, 34, 35, 37, 42, 55, 
	64, 65, 72, 79, 83, 84, 124, 9, 
	13, 110, 100, 101, 119, 32, -61, 116, 
	-80, -66, 101, 58, 10, 10, 10, 32, 
	35, 72, 124, 9, 13, 10, 119, -61, 
	10, 97, -90, 10, 10, 116, 10, 58, 
	10, 101, 104, 97, 32, 58, 104, 119, 
	-61, 97, -90, 114, 32, 115, 119, 97, 
	58, 10, 10, -61, 10, 32, 35, 37, 
	42, 55, 64, 65, 72, 79, 83, 84, 
	9, 13, -112, -98, 10, 10, 97, 117, 
	10, 32, -61, 10, 32, 34, 35, 37, 
	42, 55, 64, 65, 72, 79, 83, 84, 
	124, 9, 13, -122, -112, -98, -80, 97, 
	117, 32, -61, 10, 13, -66, 10, 13, 
	10, 13, 101, 10, 13, 32, 114, 104, 
	101, 32, 104, 97, 117, 32, 10, 13, 
	116, 10, 13, 104, 32, 124, 9, 13, 
	10, 32, 92, 124, 9, 13, 10, 92, 
	124, 10, 92, 10, 32, 92, 124, 9, 
	13, -61, 10, 32, 34, 35, 37, 42, 
	55, 64, 65, 72, 79, 83, 84, 124, 
	9, 13, 10, 114, 10, 104, 10, 32, 
	10, 97, 117, 10, 32, -61, 10, 32, 
	34, 35, 37, 42, 55, 64, 65, 72, 
	79, 83, 84, 124, 9, 13, -122, -112, 
	-98, -66, 10, 95, 10, 70, 10, 69, 
	10, 65, 10, 84, 10, 85, 10, 82, 
	10, 69, 10, 95, 10, 69, 10, 78, 
	10, 68, 10, 95, 10, 37, 10, 99, 
	10, 119, -61, 10, 97, -90, 10, 10, 
	116, 10, 58, 10, 101, 10, 110, 10, 
	100, 10, 119, 10, 97, 10, 104, 10, 
	97, 117, 10, 32, -61, 10, 32, 34, 
	35, 37, 42, 55, 64, 65, 72, 79, 
	83, 84, 116, 124, 9, 13, 104, 101, 
	10, 10, -61, 10, 32, 35, 37, 42, 
	55, 64, 65, 72, 79, 83, 84, 9, 
	13, -122, -112, -98, 10, 10, 114, 10, 
	58, 10, 97, 117, 10, 32, -61, 10, 
	32, 34, 35, 37, 42, 55, 64, 65, 
	72, 79, 83, 84, 124, 9, 13, -122, 
	-112, -98, -80, 101, 32, 10, 114, 10, 
	104, 10, 32, 10, 97, 117, 10, 32, 
	-61, 10, 32, 34, 35, 37, 42, 55, 
	64, 65, 72, 79, 83, 84, 124, 9, 
	13, -122, -112, -98, -66, 10, 95, 10, 
	70, 10, 69, 10, 65, 10, 84, 10, 
	85, 10, 82, 10, 69, 10, 95, 10, 
	69, 10, 78, 10, 68, 10, 95, 10, 
	37, 10, 99, 101, 10, 119, -61, 10, 
	97, -90, 10, 10, 116, 10, 101, 10, 
	110, 10, 100, 10, 119, 10, 97, 10, 
	32, 58, 10, 104, 10, 119, -61, 10, 
	97, -90, 10, 10, 114, 10, 32, 10, 
	115, 10, 119, 10, 97, 10, 101, 10, 
	104, 10, 97, 117, 10, 32, -61, 10, 
	32, 34, 35, 37, 42, 55, 64, 65, 
	72, 79, 83, 84, 116, 124, 9, 13, 
	104, 10, 95, 10, 70, 10, 69, 10, 
	65, 10, 84, 10, 85, 10, 82, 10, 
	69, 10, 95, 10, 69, 10, 78, 10, 
	68, 10, 95, 10, 37, 10, 101, 10, 
	119, -61, 10, 97, -90, 10, 10, 116, 
	10, 101, 10, 101, 119, 10, 32, -61, 
	10, 116, -80, -66, 10, 10, 101, 10, 
	104, 10, 97, 10, 32, 58, 10, 104, 
	10, 119, -61, 10, 97, -90, 10, 10, 
	114, 10, 32, 10, 115, 10, 119, 10, 
	97, 10, 101, 101, -80, 10, 13, 101, 
	32, 10, 114, 10, 104, 10, 32, 10, 
	97, 117, 10, 32, -61, 10, 32, 34, 
	35, 37, 42, 55, 64, 65, 72, 79, 
	83, 84, 124, 9, 13, -122, -112, -98, 
	-66, 10, 95, 10, 70, 10, 69, 10, 
	65, 10, 84, 10, 85, 10, 82, 10, 
	69, 10, 95, 10, 69, 10, 78, 10, 
	68, 10, 95, 10, 37, 10, 99, 10, 
	119, -61, 10, 97, -90, 10, 10, 116, 
	10, 58, 10, 101, 10, 110, 10, 100, 
	10, 119, 10, 97, 10, 32, 58, 10, 
	104, 10, 119, -61, 10, 97, -90, 10, 
	10, 114, 10, 32, 10, 115, 10, 119, 
	10, 97, 10, 101, 10, 104, 10, 97, 
	117, 10, 32, -61, 10, 32, 34, 35, 
	37, 42, 55, 64, 65, 72, 79, 83, 
	84, 116, 124, 9, 13, 104, -69, -65, 
	0
};

static const char _lexer_single_lengths[] = {
	0, 16, 3, 1, 1, 1, 1, 13, 
	3, 3, 2, 15, 4, 2, 1, 3, 
	2, 15, 1, 1, 2, 2, 3, 3, 
	3, 3, 2, 2, 2, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 2, 3, 5, 
	3, 2, 1, 2, 1, 1, 1, 1, 
	1, 9, 2, 2, 2, 15, 1, 1, 
	2, 1, 2, 2, 1, 1, 1, 1, 
	5, 2, 3, 2, 2, 2, 2, 1, 
	1, 2, 1, 1, 2, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 13, 3, 
	3, 2, 15, 4, 2, 1, 3, 3, 
	3, 3, 1, 1, 1, 1, 1, 2, 
	1, 3, 3, 2, 4, 3, 2, 4, 
	15, 2, 2, 2, 3, 2, 15, 4, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	3, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 3, 2, 16, 1, 1, 1, 
	1, 13, 4, 2, 2, 3, 2, 15, 
	4, 1, 1, 2, 2, 2, 3, 2, 
	15, 4, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	3, 2, 3, 2, 2, 2, 2, 2, 
	2, 2, 3, 2, 2, 3, 2, 2, 
	2, 2, 2, 2, 2, 2, 3, 2, 
	16, 1, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 3, 2, 2, 2, 3, 2, 
	3, 3, 2, 2, 2, 3, 2, 2, 
	3, 2, 2, 2, 2, 2, 2, 2, 
	1, 3, 1, 1, 2, 2, 2, 3, 
	2, 15, 4, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 3, 2, 2, 2, 2, 
	2, 2, 2, 2, 3, 2, 2, 3, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	3, 2, 16, 1, 1, 1, 0
};

static const char _lexer_range_lengths[] = {
	0, 1, 0, 0, 0, 0, 0, 1, 
	0, 0, 0, 1, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 1, 1, 
	1, 1, 1, 1, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 1, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 1, 1, 0, 0, 1, 
	1, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 0
};

static const short _lexer_index_offsets[] = {
	0, 0, 18, 22, 24, 26, 28, 30, 
	45, 49, 53, 56, 73, 78, 81, 83, 
	87, 90, 107, 109, 111, 114, 117, 122, 
	127, 132, 137, 141, 145, 148, 150, 152, 
	154, 156, 158, 160, 162, 164, 166, 168, 
	170, 172, 174, 176, 178, 180, 183, 188, 
	195, 200, 203, 205, 208, 210, 212, 214, 
	216, 218, 229, 232, 235, 238, 255, 257, 
	259, 262, 264, 267, 270, 272, 274, 276, 
	278, 285, 288, 292, 295, 298, 301, 304, 
	306, 308, 311, 313, 315, 318, 320, 322, 
	324, 326, 328, 330, 332, 334, 336, 351, 
	355, 359, 362, 379, 384, 387, 389, 393, 
	397, 401, 405, 407, 409, 411, 413, 415, 
	418, 420, 424, 428, 432, 438, 442, 445, 
	451, 468, 471, 474, 477, 481, 484, 501, 
	506, 509, 512, 515, 518, 521, 524, 527, 
	530, 533, 536, 539, 542, 545, 548, 551, 
	554, 558, 561, 564, 567, 570, 573, 576, 
	579, 582, 585, 589, 592, 610, 612, 614, 
	616, 618, 633, 638, 641, 644, 648, 651, 
	668, 673, 675, 677, 680, 683, 686, 690, 
	693, 710, 715, 718, 721, 724, 727, 730, 
	733, 736, 739, 742, 745, 748, 751, 754, 
	757, 761, 764, 768, 771, 774, 777, 780, 
	783, 786, 789, 793, 796, 799, 803, 806, 
	809, 812, 815, 818, 821, 824, 827, 831, 
	834, 852, 854, 857, 860, 863, 866, 869, 
	872, 875, 878, 881, 884, 887, 890, 893, 
	896, 899, 902, 906, 909, 912, 915, 919, 
	922, 926, 930, 933, 936, 939, 943, 946, 
	949, 953, 956, 959, 962, 965, 968, 971, 
	974, 976, 980, 982, 984, 987, 990, 993, 
	997, 1000, 1017, 1022, 1025, 1028, 1031, 1034, 
	1037, 1040, 1043, 1046, 1049, 1052, 1055, 1058, 
	1061, 1064, 1067, 1070, 1074, 1077, 1080, 1083, 
	1086, 1089, 1092, 1095, 1098, 1102, 1105, 1108, 
	1112, 1115, 1118, 1121, 1124, 1127, 1130, 1133, 
	1136, 1140, 1143, 1161, 1163, 1165, 1167
};

static const short _lexer_trans_targs[] = {
	2, 308, 17, 17, 18, 28, 30, 44, 
	44, 46, 49, 50, 62, 64, 110, 115, 
	17, 0, 3, 13, 100, 0, 4, 0, 
	5, 0, 7, 6, 7, 6, 8, 7, 
	7, 17, 267, 262, 262, 17, 281, 282, 
	288, 290, 303, 7, 6, 9, 263, 7, 
	6, 7, 10, 260, 6, 7, 11, 6, 
	12, 17, 17, 18, 28, 30, 44, 44, 
	46, 49, 50, 62, 64, 110, 115, 17, 
	0, 3, 13, 100, 258, 0, 14, 106, 
	0, 15, 0, 257, 17, 29, 16, 17, 
	29, 16, 2, 17, 17, 18, 28, 30, 
	44, 44, 46, 49, 50, 62, 64, 110, 
	115, 17, 0, 19, 0, 20, 0, 22, 
	21, 21, 22, 21, 21, 23, 23, 24, 
	23, 23, 23, 23, 24, 23, 23, 23, 
	23, 25, 23, 23, 23, 23, 26, 23, 
	23, 17, 27, 27, 0, 17, 27, 27, 
	0, 17, 29, 28, 17, 0, 31, 0, 
	32, 0, 33, 0, 34, 0, 35, 0, 
	36, 0, 37, 0, 38, 0, 39, 0, 
	40, 0, 41, 0, 42, 0, 43, 0, 
	310, 0, 45, 0, 17, 29, 16, 0, 
	0, 0, 0, 47, 48, 17, 48, 48, 
	46, 47, 47, 17, 48, 46, 48, 0, 
	44, 3, 0, 51, 0, 52, 256, 0, 
	53, 0, 54, 0, 55, 0, 57, 56, 
	57, 56, 58, 57, 57, 17, 218, 17, 
	232, 233, 238, 57, 56, 59, 57, 56, 
	57, 60, 56, 57, 61, 56, 2, 17, 
	17, 18, 28, 30, 44, 44, 46, 49, 
	50, 62, 64, 110, 115, 17, 0, 63, 
	0, 44, 0, 65, 80, 0, 66, 0, 
	67, 79, 0, 68, 68, 0, 69, 0, 
	70, 0, 72, 71, 72, 71, 72, 72, 
	17, 73, 17, 72, 71, 72, 74, 71, 
	75, 72, 78, 71, 76, 72, 71, 72, 
	77, 71, 72, 61, 71, 72, 76, 71, 
	68, 0, 81, 0, 82, 159, 0, 83, 
	0, 84, 0, 85, 158, 0, 86, 0, 
	87, 0, 88, 0, 89, 0, 90, 0, 
	91, 0, 92, 0, 94, 93, 94, 93, 
	95, 94, 94, 17, 128, 123, 123, 17, 
	142, 143, 149, 151, 153, 94, 93, 96, 
	124, 94, 93, 94, 97, 121, 93, 94, 
	98, 93, 99, 17, 17, 18, 28, 30, 
	44, 44, 46, 49, 50, 62, 64, 110, 
	115, 17, 0, 3, 13, 100, 108, 0, 
	101, 106, 0, 102, 0, 103, 17, 29, 
	16, 104, 17, 29, 16, 17, 29, 105, 
	16, 17, 29, 45, 16, 107, 0, 44, 
	0, 109, 0, 61, 0, 111, 0, 112, 
	106, 0, 113, 0, 17, 29, 114, 16, 
	17, 29, 104, 16, 115, 116, 115, 0, 
	120, 119, 118, 116, 119, 117, 0, 118, 
	116, 117, 0, 118, 117, 120, 119, 118, 
	116, 119, 117, 2, 120, 120, 18, 28, 
	30, 44, 44, 46, 49, 50, 62, 64, 
	110, 115, 120, 0, 94, 122, 93, 94, 
	123, 93, 94, 61, 93, 94, 125, 121, 
	93, 94, 126, 93, 127, 17, 17, 18, 
	28, 30, 44, 44, 46, 49, 50, 62, 
	64, 110, 115, 17, 0, 3, 13, 100, 
	108, 0, 94, 129, 93, 94, 130, 93, 
	94, 131, 93, 94, 132, 93, 94, 133, 
	93, 94, 134, 93, 94, 135, 93, 94, 
	136, 93, 94, 137, 93, 94, 138, 93, 
	94, 139, 93, 94, 140, 93, 94, 141, 
	93, 94, 17, 93, 94, 123, 93, 94, 
	144, 93, 145, 94, 148, 93, 146, 94, 
	93, 94, 147, 93, 94, 61, 93, 94, 
	146, 93, 94, 150, 93, 94, 123, 93, 
	94, 152, 93, 94, 147, 93, 94, 154, 
	93, 94, 155, 121, 93, 94, 156, 93, 
	2, 17, 17, 18, 28, 30, 44, 44, 
	46, 49, 50, 62, 64, 110, 157, 115, 
	17, 0, 108, 0, 86, 0, 161, 160, 
	161, 160, 162, 161, 161, 17, 178, 173, 
	173, 17, 192, 193, 198, 200, 213, 161, 
	160, 163, 165, 174, 161, 160, 161, 164, 
	160, 161, 61, 160, 161, 166, 171, 160, 
	161, 167, 160, 168, 17, 17, 18, 28, 
	30, 44, 44, 46, 49, 50, 62, 64, 
	110, 115, 17, 0, 3, 13, 100, 169, 
	0, 170, 0, 61, 0, 161, 172, 160, 
	161, 173, 160, 161, 61, 160, 161, 175, 
	171, 160, 161, 176, 160, 177, 17, 17, 
	18, 28, 30, 44, 44, 46, 49, 50, 
	62, 64, 110, 115, 17, 0, 3, 13, 
	100, 169, 0, 161, 179, 160, 161, 180, 
	160, 161, 181, 160, 161, 182, 160, 161, 
	183, 160, 161, 184, 160, 161, 185, 160, 
	161, 186, 160, 161, 187, 160, 161, 188, 
	160, 161, 189, 160, 161, 190, 160, 161, 
	191, 160, 161, 17, 160, 161, 173, 163, 
	160, 161, 194, 160, 195, 161, 197, 160, 
	196, 161, 160, 161, 164, 160, 161, 196, 
	160, 161, 199, 160, 161, 173, 160, 161, 
	201, 160, 161, 202, 160, 161, 203, 61, 
	160, 161, 204, 160, 161, 205, 160, 206, 
	161, 212, 160, 207, 161, 160, 161, 208, 
	160, 161, 209, 160, 161, 210, 160, 161, 
	211, 160, 161, 164, 160, 161, 207, 160, 
	161, 214, 160, 161, 215, 171, 160, 161, 
	216, 160, 2, 17, 17, 18, 28, 30, 
	44, 44, 46, 49, 50, 62, 64, 110, 
	217, 115, 17, 0, 169, 0, 57, 219, 
	56, 57, 220, 56, 57, 221, 56, 57, 
	222, 56, 57, 223, 56, 57, 224, 56, 
	57, 225, 56, 57, 226, 56, 57, 227, 
	56, 57, 228, 56, 57, 229, 56, 57, 
	230, 56, 57, 231, 56, 57, 17, 56, 
	57, 59, 56, 57, 234, 56, 235, 57, 
	237, 56, 236, 57, 56, 57, 60, 56, 
	57, 236, 56, 57, 239, 244, 56, 57, 
	240, 56, 241, 57, 243, 56, 242, 242, 
	57, 56, 57, 60, 56, 57, 242, 56, 
	57, 245, 56, 57, 246, 61, 56, 57, 
	247, 56, 57, 248, 56, 249, 57, 255, 
	56, 250, 57, 56, 57, 251, 56, 57, 
	252, 56, 57, 253, 56, 57, 254, 56, 
	57, 60, 56, 57, 250, 56, 53, 0, 
	104, 17, 29, 16, 259, 0, 61, 0, 
	7, 261, 6, 7, 262, 6, 7, 61, 
	6, 7, 264, 260, 6, 7, 265, 6, 
	266, 17, 17, 18, 28, 30, 44, 44, 
	46, 49, 50, 62, 64, 110, 115, 17, 
	0, 3, 13, 100, 258, 0, 7, 268, 
	6, 7, 269, 6, 7, 270, 6, 7, 
	271, 6, 7, 272, 6, 7, 273, 6, 
	7, 274, 6, 7, 275, 6, 7, 276, 
	6, 7, 277, 6, 7, 278, 6, 7, 
	279, 6, 7, 280, 6, 7, 17, 6, 
	7, 262, 6, 7, 283, 6, 284, 7, 
	287, 6, 285, 7, 6, 7, 286, 6, 
	7, 61, 6, 7, 285, 6, 7, 289, 
	6, 7, 262, 6, 7, 291, 6, 7, 
	292, 6, 7, 293, 61, 6, 7, 294, 
	6, 7, 295, 6, 296, 7, 302, 6, 
	297, 7, 6, 7, 298, 6, 7, 299, 
	6, 7, 300, 6, 7, 301, 6, 7, 
	286, 6, 7, 297, 6, 7, 304, 6, 
	7, 305, 260, 6, 7, 306, 6, 2, 
	17, 17, 18, 28, 30, 44, 44, 46, 
	49, 50, 62, 64, 110, 307, 115, 17, 
	0, 258, 0, 309, 0, 17, 0, 0, 
	0
};

static const unsigned char _lexer_trans_actions[] = {
	29, 0, 54, 0, 5, 1, 0, 29, 
	29, 1, 29, 29, 29, 29, 29, 35, 
	0, 43, 0, 0, 0, 43, 0, 43, 
	0, 43, 144, 57, 54, 0, 84, 54, 
	0, 72, 33, 84, 84, 72, 84, 84, 
	84, 84, 84, 0, 0, 0, 0, 54, 
	0, 54, 0, 0, 0, 54, 15, 0, 
	63, 130, 31, 60, 57, 31, 63, 63, 
	57, 63, 63, 63, 63, 63, 66, 31, 
	43, 0, 0, 0, 0, 43, 0, 0, 
	43, 0, 43, 57, 149, 126, 57, 110, 
	23, 0, 29, 54, 0, 5, 1, 0, 
	29, 29, 1, 29, 29, 29, 29, 29, 
	35, 0, 43, 0, 43, 0, 43, 139, 
	48, 9, 106, 11, 0, 134, 45, 45, 
	45, 3, 122, 33, 33, 33, 0, 122, 
	33, 33, 33, 0, 122, 33, 0, 33, 
	0, 102, 7, 7, 43, 54, 0, 0, 
	43, 114, 25, 0, 54, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 149, 126, 57, 43, 
	43, 43, 43, 0, 27, 118, 27, 27, 
	51, 27, 0, 54, 0, 1, 0, 43, 
	0, 0, 43, 0, 43, 0, 0, 43, 
	0, 43, 0, 43, 0, 43, 144, 57, 
	54, 0, 84, 54, 0, 69, 33, 69, 
	84, 84, 84, 0, 0, 0, 54, 0, 
	54, 0, 0, 54, 13, 0, 63, 130, 
	31, 60, 57, 31, 63, 63, 57, 63, 
	63, 63, 63, 63, 66, 31, 43, 0, 
	43, 0, 43, 0, 0, 43, 0, 43, 
	0, 0, 43, 0, 0, 43, 0, 43, 
	0, 43, 144, 57, 54, 0, 54, 0, 
	81, 84, 81, 0, 0, 54, 0, 0, 
	0, 54, 0, 0, 0, 54, 0, 54, 
	0, 0, 54, 21, 0, 54, 0, 0, 
	0, 43, 0, 43, 0, 0, 43, 0, 
	43, 0, 43, 0, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 144, 57, 54, 0, 
	84, 54, 0, 78, 33, 84, 84, 78, 
	84, 84, 84, 84, 84, 0, 0, 0, 
	0, 54, 0, 54, 0, 0, 0, 54, 
	19, 0, 63, 130, 31, 60, 57, 31, 
	63, 63, 57, 63, 63, 63, 63, 63, 
	66, 31, 43, 0, 0, 0, 0, 43, 
	0, 0, 43, 0, 43, 57, 149, 126, 
	57, 0, 110, 23, 0, 110, 23, 0, 
	0, 110, 23, 0, 0, 0, 43, 0, 
	43, 0, 43, 19, 43, 0, 43, 0, 
	0, 43, 0, 43, 149, 126, 57, 57, 
	110, 23, 0, 0, 0, 0, 0, 43, 
	54, 37, 37, 87, 37, 37, 43, 0, 
	39, 0, 43, 0, 0, 54, 0, 0, 
	39, 0, 0, 96, 54, 0, 93, 90, 
	41, 96, 96, 90, 96, 96, 96, 96, 
	96, 99, 0, 43, 54, 0, 0, 54, 
	0, 0, 54, 19, 0, 54, 0, 0, 
	0, 54, 19, 0, 63, 130, 31, 60, 
	57, 31, 63, 63, 57, 63, 63, 63, 
	63, 63, 66, 31, 43, 0, 0, 0, 
	0, 43, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 19, 0, 54, 0, 0, 54, 
	0, 0, 0, 54, 0, 0, 0, 54, 
	0, 54, 0, 0, 54, 19, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 0, 54, 19, 0, 
	63, 130, 31, 60, 57, 31, 63, 63, 
	57, 63, 63, 63, 63, 63, 0, 66, 
	31, 43, 0, 43, 0, 43, 144, 57, 
	54, 0, 84, 54, 0, 75, 33, 84, 
	84, 75, 84, 84, 84, 84, 84, 0, 
	0, 0, 0, 0, 54, 0, 54, 0, 
	0, 54, 17, 0, 54, 0, 0, 0, 
	54, 17, 0, 63, 130, 31, 60, 57, 
	31, 63, 63, 57, 63, 63, 63, 63, 
	63, 66, 31, 43, 0, 0, 0, 0, 
	43, 0, 43, 17, 43, 54, 0, 0, 
	54, 0, 0, 54, 17, 0, 54, 0, 
	0, 0, 54, 17, 0, 63, 130, 31, 
	60, 57, 31, 63, 63, 57, 63, 63, 
	63, 63, 63, 66, 31, 43, 0, 0, 
	0, 0, 43, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 17, 0, 54, 0, 0, 
	0, 54, 0, 0, 0, 54, 0, 0, 
	0, 54, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 17, 
	0, 54, 0, 0, 54, 0, 0, 0, 
	54, 0, 0, 0, 54, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 0, 54, 
	17, 0, 63, 130, 31, 60, 57, 31, 
	63, 63, 57, 63, 63, 63, 63, 63, 
	0, 66, 31, 43, 0, 43, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 13, 0, 
	54, 0, 0, 54, 0, 0, 0, 54, 
	0, 0, 0, 54, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 0, 54, 
	0, 0, 0, 54, 0, 0, 0, 0, 
	54, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 13, 0, 54, 
	0, 0, 54, 0, 0, 0, 54, 0, 
	0, 0, 54, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 0, 43, 
	0, 110, 23, 0, 0, 43, 15, 43, 
	54, 0, 0, 54, 0, 0, 54, 15, 
	0, 54, 0, 0, 0, 54, 15, 0, 
	63, 130, 31, 60, 57, 31, 63, 63, 
	57, 63, 63, 63, 63, 63, 66, 31, 
	43, 0, 0, 0, 0, 43, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 15, 0, 
	54, 0, 0, 54, 0, 0, 0, 54, 
	0, 0, 0, 54, 0, 54, 0, 0, 
	54, 15, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 15, 0, 54, 0, 
	0, 54, 0, 0, 0, 54, 0, 0, 
	0, 54, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 0, 54, 15, 0, 63, 
	130, 31, 60, 57, 31, 63, 63, 57, 
	63, 63, 63, 63, 63, 0, 66, 31, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	0
};

static const unsigned char _lexer_eof_actions[] = {
	0, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43
};

static const int lexer_start = 1;
static const int lexer_first_final = 310;
static const int lexer_error = 0;

static const int lexer_en_main = 1;


#line 258 "ragel/i18n/en_old.c.rl"

static VALUE 
unindent(VALUE con, int start_col)
{
  VALUE re;
  /* Gherkin will crash gracefully if the string representation of start_col pushes the pattern past 32 characters */
  char pat[32]; 
  snprintf(pat, 32, "^[\t ]{0,%d}", start_col); 
  re = rb_reg_regcomp(rb_str_new2(pat));
  rb_funcall(con, rb_intern("gsub!"), 2, re, rb_str_new2(""));

  return Qnil;

}

static void 
store_kw_con(VALUE listener, const char * event_name, 
             const char * keyword_at, size_t keyword_length, 
             const char * at,         size_t length, 
             int current_line)
{
  VALUE con = Qnil, kw = Qnil;
  kw = ENCODED_STR_NEW(keyword_at, keyword_length);
  con = ENCODED_STR_NEW(at, length);
  rb_funcall(con, rb_intern("strip!"), 0);
  rb_funcall(listener, rb_intern(event_name), 3, kw, con, INT2FIX(current_line)); 
}

static void
store_multiline_kw_con(VALUE listener, const char * event_name,
                      const char * keyword_at, size_t keyword_length,
                      const char * at,         size_t length,
                      int current_line, int start_col)
{
  VALUE split;
  VALUE con = Qnil, kw = Qnil, name = Qnil, desc = Qnil;

  kw = ENCODED_STR_NEW(keyword_at, keyword_length);
  con = ENCODED_STR_NEW(at, length);

  unindent(con, start_col);
  
  split = rb_str_split(con, "\n");

  name = rb_funcall(split, rb_intern("shift"), 0);
  desc = rb_ary_join(split, rb_str_new2( "\n" ));

  if( name == Qnil ) 
  {
    name = rb_str_new2("");
  }
  if( rb_funcall(desc, rb_intern("size"), 0) == 0) 
  {
    desc = rb_str_new2("");
  }
  rb_funcall(name, rb_intern("strip!"), 0);
  rb_funcall(desc, rb_intern("rstrip!"), 0);
  rb_funcall(listener, rb_intern(event_name), 4, kw, name, desc, INT2FIX(current_line)); 
}

static void 
store_attr(VALUE listener, const char * attr_type,
           const char * at, size_t length, 
           int line)
{
  VALUE val = ENCODED_STR_NEW(at, length);
  rb_funcall(listener, rb_intern(attr_type), 2, val, INT2FIX(line));
}
static void 
store_docstring_content(VALUE listener, 
          int start_col, 
          const char *type_at, size_t type_length,
          const char *at, size_t length, 
          int current_line)
{
  VALUE re2;
  VALUE unescape_escaped_quotes;
  VALUE con = ENCODED_STR_NEW(at, length);
  VALUE con_type = ENCODED_STR_NEW(type_at, type_length);

  unindent(con, start_col);

  re2 = rb_reg_regcomp(rb_str_new2("\r\\Z"));
  unescape_escaped_quotes = rb_reg_regcomp(rb_str_new2("\\\\\"\\\\\"\\\\\""));
  rb_funcall(con, rb_intern("sub!"), 2, re2, rb_str_new2(""));
  rb_funcall(con_type, rb_intern("strip!"), 0);
  rb_funcall(con, rb_intern("gsub!"), 2, unescape_escaped_quotes, rb_str_new2("\"\"\""));
  rb_funcall(listener, rb_intern("doc_string"), 3, con_type, con, INT2FIX(current_line));
}
static void 
raise_lexer_error(const char * at, int line)
{ 
  rb_raise(rb_eGherkinLexingError, "Lexing error on line %d: '%s'. See http://wiki.github.com/cucumber/gherkin/lexingerror for more information.", line, at);
}

static void lexer_init(lexer_state *lexer) {
  lexer->content_start = 0;
  lexer->content_end = 0;
  lexer->content_len = 0;
  lexer->docstring_content_type_start = 0;
  lexer->docstring_content_type_end = 0;
  lexer->mark = 0;
  lexer->keyword_start = 0;
  lexer->keyword_end = 0;
  lexer->next_keyword_start = 0;
  lexer->line_number = 1;
  lexer->last_newline = 0;
  lexer->final_newline = 0;
  lexer->start_col = 0;
}

static VALUE CLexer_alloc(VALUE klass)
{
  VALUE obj;
  lexer_state *lxr = ALLOC(lexer_state);
  lexer_init(lxr);

  obj = Data_Wrap_Struct(klass, NULL, -1, lxr);

  return obj;
}

static VALUE CLexer_init(VALUE self, VALUE listener)
{
  lexer_state *lxr; 
  rb_iv_set(self, "@listener", listener);
  
  lxr = NULL;
  DATA_GET(self, lexer_state, lxr);
  lexer_init(lxr);
  
  return self;
}

static VALUE CLexer_scan(VALUE self, VALUE input)
{
  VALUE input_copy;
  char *data;
  size_t len;
  VALUE listener = rb_iv_get(self, "@listener");

  lexer_state *lexer;
  lexer = NULL;
  DATA_GET(self, lexer_state, lexer);

  input_copy = rb_str_dup(input);

  rb_str_append(input_copy, rb_str_new2("\n%_FEATURE_END_%"));
  data = RSTRING_PTR(input_copy);
  len = RSTRING_LEN(input_copy);
  
  if (len == 0) { 
    rb_raise(rb_eGherkinLexingError, "No content to lex.");
  } else {

    const char *p, *pe, *eof;
    int cs = 0;
    
    VALUE current_row = Qnil;

    p = data;
    pe = data + len;
    eof = pe;
    
    assert(*pe == '\0' && "pointer does not end on NULL");
    
    
#line 913 "ext/gherkin_lexer_en_old/gherkin_lexer_en_old.c"
	{
	cs = lexer_start;
	}

#line 425 "ragel/i18n/en_old.c.rl"
    
#line 920 "ext/gherkin_lexer_en_old/gherkin_lexer_en_old.c"
	{
	int _klen;
	unsigned int _trans;
	const char *_acts;
	unsigned int _nacts;
	const char *_keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_keys = _lexer_trans_keys + _lexer_key_offsets[cs];
	_trans = _lexer_index_offsets[cs];

	_klen = _lexer_single_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( (*p) < *_mid )
				_upper = _mid - 1;
			else if ( (*p) > *_mid )
				_lower = _mid + 1;
			else {
				_trans += (unsigned int)(_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _lexer_range_lengths[cs];
	if ( _klen > 0 ) {
		const char *_lower = _keys;
		const char *_mid;
		const char *_upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( (*p) < _mid[0] )
				_upper = _mid - 2;
			else if ( (*p) > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += (unsigned int)((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	cs = _lexer_trans_targs[_trans];

	if ( _lexer_trans_actions[_trans] == 0 )
		goto _again;

	_acts = _lexer_actions + _lexer_trans_actions[_trans];
	_nacts = (unsigned int) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 0:
#line 83 "ragel/i18n/en_old.c.rl"
	{
		MARK(content_start, p);
    lexer->current_line = lexer->line_number;
    lexer->start_col = lexer->content_start - lexer->last_newline - (lexer->keyword_end - lexer->keyword_start) + 2;
  }
	break;
	case 1:
#line 89 "ragel/i18n/en_old.c.rl"
	{
    MARK(content_start, p);
  }
	break;
	case 2:
#line 93 "ragel/i18n/en_old.c.rl"
	{
    lexer->current_line = lexer->line_number;
    lexer->start_col = p - data - lexer->last_newline;
  }
	break;
	case 3:
#line 98 "ragel/i18n/en_old.c.rl"
	{
    int len = LEN(content_start, PTR_TO(final_newline));
    int type_len = LEN(docstring_content_type_start, PTR_TO(docstring_content_type_end));

    if (len < 0) len = 0;
    if (type_len < 0) len = 0;

    store_docstring_content(listener, lexer->start_col, PTR_TO(docstring_content_type_start), type_len, PTR_TO(content_start), len, lexer->current_line);
  }
	break;
	case 4:
#line 108 "ragel/i18n/en_old.c.rl"
	{ 
    MARK(docstring_content_type_start, p);
  }
	break;
	case 5:
#line 112 "ragel/i18n/en_old.c.rl"
	{ 
    MARK(docstring_content_type_end, p);
  }
	break;
	case 6:
#line 116 "ragel/i18n/en_old.c.rl"
	{
    STORE_KW_END_CON(feature);
  }
	break;
	case 7:
#line 120 "ragel/i18n/en_old.c.rl"
	{
    STORE_KW_END_CON(background);
  }
	break;
	case 8:
#line 124 "ragel/i18n/en_old.c.rl"
	{
    STORE_KW_END_CON(scenario);
  }
	break;
	case 9:
#line 128 "ragel/i18n/en_old.c.rl"
	{
    STORE_KW_END_CON(scenario_outline);
  }
	break;
	case 10:
#line 132 "ragel/i18n/en_old.c.rl"
	{
    STORE_KW_END_CON(examples);
  }
	break;
	case 11:
#line 136 "ragel/i18n/en_old.c.rl"
	{
    store_kw_con(listener, "step",
      PTR_TO(keyword_start), LEN(keyword_start, PTR_TO(keyword_end)),
      PTR_TO(content_start), LEN(content_start, p), 
      lexer->current_line);
  }
	break;
	case 12:
#line 143 "ragel/i18n/en_old.c.rl"
	{
    STORE_ATTR(comment);
    lexer->mark = 0;
  }
	break;
	case 13:
#line 148 "ragel/i18n/en_old.c.rl"
	{
    STORE_ATTR(tag);
    lexer->mark = 0;
  }
	break;
	case 14:
#line 153 "ragel/i18n/en_old.c.rl"
	{
    lexer->line_number += 1;
    MARK(final_newline, p);
  }
	break;
	case 15:
#line 158 "ragel/i18n/en_old.c.rl"
	{
    MARK(last_newline, p + 1);
  }
	break;
	case 16:
#line 162 "ragel/i18n/en_old.c.rl"
	{
    if (lexer->mark == 0) {
      MARK(mark, p);
    }
  }
	break;
	case 17:
#line 168 "ragel/i18n/en_old.c.rl"
	{
    MARK(keyword_end, p);
    MARK(keyword_start, PTR_TO(mark));
    MARK(content_start, p + 1);
    lexer->mark = 0;
  }
	break;
	case 18:
#line 175 "ragel/i18n/en_old.c.rl"
	{
    MARK(content_end, p);
  }
	break;
	case 19:
#line 179 "ragel/i18n/en_old.c.rl"
	{
    p = p - 1;
    lexer->current_line = lexer->line_number;
    current_row = rb_ary_new();
  }
	break;
	case 20:
#line 185 "ragel/i18n/en_old.c.rl"
	{
		MARK(content_start, p);
  }
	break;
	case 21:
#line 189 "ragel/i18n/en_old.c.rl"
	{
    VALUE re_pipe, re_newline, re_backslash;
    VALUE con = ENCODED_STR_NEW(PTR_TO(content_start), LEN(content_start, p));
    rb_funcall(con, rb_intern("strip!"), 0);
    re_pipe      = rb_reg_regcomp(rb_str_new2("\\\\\\|"));
    re_newline   = rb_reg_regcomp(rb_str_new2("\\\\n"));
    re_backslash = rb_reg_regcomp(rb_str_new2("\\\\\\\\"));
    rb_funcall(con, rb_intern("gsub!"), 2, re_pipe,      rb_str_new2("|"));
    rb_funcall(con, rb_intern("gsub!"), 2, re_newline,   rb_str_new2("\n"));
    rb_funcall(con, rb_intern("gsub!"), 2, re_backslash, rb_str_new2("\\"));

    rb_ary_push(current_row, con);
  }
	break;
	case 22:
#line 203 "ragel/i18n/en_old.c.rl"
	{
    rb_funcall(listener, rb_intern("row"), 2, current_row, INT2FIX(lexer->current_line));
  }
	break;
	case 23:
#line 207 "ragel/i18n/en_old.c.rl"
	{
    int line;
    if (cs < lexer_first_final) {
      size_t count = 0;
      VALUE newstr_val;
      char *newstr;
      int newstr_count = 0;        
      size_t len;
      const char *buff;
      if (lexer->last_newline != 0) {
        len = LEN(last_newline, eof);
        buff = PTR_TO(last_newline);
      } else {
        len = strlen(data);
        buff = data;
      }

      /* Allocate as a ruby string so that it gets cleaned up by GC */
      newstr_val = rb_str_new(buff, len);
      newstr = RSTRING_PTR(newstr_val);


      for (count = 0; count < len; count++) {
        if(buff[count] == 10) {
          newstr[newstr_count] = '\0'; /* terminate new string at first newline found */
          break;
        } else {
          if (buff[count] == '%') {
            newstr[newstr_count++] = buff[count];
            newstr[newstr_count] = buff[count];
          } else {
            newstr[newstr_count] = buff[count];
          }
        }
        newstr_count++;
      }

      line = lexer->line_number;
      lexer_init(lexer); /* Re-initialize so we can scan again with the same lexer */
      raise_lexer_error(newstr, line);
    } else {
      rb_funcall(listener, rb_intern("eof"), 0);
    }
  }
	break;
#line 1210 "ext/gherkin_lexer_en_old/gherkin_lexer_en_old.c"
		}
	}

_again:
	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	const char *__acts = _lexer_actions + _lexer_eof_actions[cs];
	unsigned int __nacts = (unsigned int) *__acts++;
	while ( __nacts-- > 0 ) {
		switch ( *__acts++ ) {
	case 23:
#line 207 "ragel/i18n/en_old.c.rl"
	{
    int line;
    if (cs < lexer_first_final) {
      size_t count = 0;
      VALUE newstr_val;
      char *newstr;
      int newstr_count = 0;        
      size_t len;
      const char *buff;
      if (lexer->last_newline != 0) {
        len = LEN(last_newline, eof);
        buff = PTR_TO(last_newline);
      } else {
        len = strlen(data);
        buff = data;
      }

      /* Allocate as a ruby string so that it gets cleaned up by GC */
      newstr_val = rb_str_new(buff, len);
      newstr = RSTRING_PTR(newstr_val);


      for (count = 0; count < len; count++) {
        if(buff[count] == 10) {
          newstr[newstr_count] = '\0'; /* terminate new string at first newline found */
          break;
        } else {
          if (buff[count] == '%') {
            newstr[newstr_count++] = buff[count];
            newstr[newstr_count] = buff[count];
          } else {
            newstr[newstr_count] = buff[count];
          }
        }
        newstr_count++;
      }

      line = lexer->line_number;
      lexer_init(lexer); /* Re-initialize so we can scan again with the same lexer */
      raise_lexer_error(newstr, line);
    } else {
      rb_funcall(listener, rb_intern("eof"), 0);
    }
  }
	break;
#line 1273 "ext/gherkin_lexer_en_old/gherkin_lexer_en_old.c"
		}
	}
	}

	_out: {}
	}

#line 426 "ragel/i18n/en_old.c.rl"

    assert(p <= pe && "data overflow after parsing execute");
    assert(lexer->content_start <= len && "content starts after data end");
    assert(lexer->mark < len && "mark is after data end");
    
    /* Reset lexer by re-initializing the whole thing */
    lexer_init(lexer);

    if (cs == lexer_error) {
      rb_raise(rb_eGherkinLexingError, "Invalid format, lexing fails.");
    } else {
      return Qtrue;
    }
  }
}

void Init_gherkin_lexer_en_old()
{
  mGherkin = rb_define_module("Gherkin");
  mGherkinLexer = rb_define_module_under(mGherkin, "Lexer");
  rb_eGherkinLexingError = rb_const_get(mGherkinLexer, rb_intern("LexingError"));

  mCLexer = rb_define_module_under(mGherkin, "CLexer");
  cI18nLexer = rb_define_class_under(mCLexer, "En_old", rb_cObject);
  rb_define_alloc_func(cI18nLexer, CLexer_alloc);
  rb_define_method(cI18nLexer, "initialize", CLexer_init, 1);
  rb_define_method(cI18nLexer, "scan", CLexer_scan, 1);
}

