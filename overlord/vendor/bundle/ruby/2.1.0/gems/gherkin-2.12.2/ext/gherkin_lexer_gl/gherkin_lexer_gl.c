
#line 1 "ragel/i18n/gl.c.rl"
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


#line 254 "ragel/i18n/gl.c.rl"


/** Data **/

#line 89 "ext/gherkin_lexer_gl/gherkin_lexer_gl.c"
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
	0, 0, 17, 18, 19, 35, 36, 37, 
	39, 41, 46, 51, 56, 61, 65, 69, 
	71, 72, 73, 74, 75, 76, 77, 78, 
	79, 80, 81, 82, 83, 84, 85, 86, 
	87, 89, 91, 96, 103, 108, 110, 112, 
	113, 114, 115, 116, 117, 118, 119, 120, 
	121, 122, 123, 124, 125, 126, 127, 128, 
	129, 138, 140, 142, 144, 146, 148, 150, 
	152, 154, 156, 158, 160, 162, 164, 166, 
	169, 171, 173, 175, 177, 179, 181, 183, 
	185, 187, 189, 191, 193, 195, 197, 213, 
	214, 215, 217, 219, 223, 224, 225, 226, 
	227, 229, 230, 231, 232, 233, 234, 235, 
	236, 237, 238, 239, 240, 241, 242, 243, 
	244, 245, 246, 247, 248, 262, 264, 266, 
	268, 270, 272, 274, 276, 278, 280, 282, 
	284, 286, 288, 290, 292, 294, 297, 299, 
	301, 303, 305, 307, 309, 311, 313, 315, 
	317, 319, 321, 323, 325, 327, 329, 331, 
	334, 337, 341, 343, 345, 347, 349, 351, 
	353, 355, 357, 359, 361, 363, 365, 367, 
	369, 371, 373, 375, 377, 378, 379, 380, 
	381, 382, 383, 384, 385, 386, 400, 402, 
	404, 406, 408, 410, 412, 414, 416, 418, 
	420, 422, 424, 426, 428, 430, 433, 436, 
	438, 440, 442, 444, 446, 448, 450, 452, 
	454, 456, 458, 460, 462, 464, 466, 468, 
	470, 472, 474, 476, 478, 480, 482, 485, 
	488, 492, 494, 496, 498, 500, 503, 505, 
	507, 509, 511, 513, 515, 517, 519, 521, 
	523, 525, 527, 529, 531, 533, 535, 537, 
	539, 541, 543, 545, 547, 548, 549, 550, 
	551, 552, 553, 554, 555, 556, 563, 565, 
	567, 569, 571, 573, 575, 577, 579, 581, 
	583, 585, 587, 589, 591, 593, 594, 595, 
	596, 597, 598, 599, 600, 604, 610, 613, 
	615, 621, 637, 639, 641, 643, 645, 647, 
	649, 652, 655, 657, 659, 661, 663, 665, 
	667, 669, 671, 673, 675, 677, 679, 681, 
	683, 685, 687, 689, 691, 693, 695, 697, 
	698, 699, 700, 701, 702, 703, 704, 705, 
	706, 720, 722, 724, 726, 728, 730, 732, 
	734, 736, 738, 740, 742, 744, 746, 748, 
	750, 752, 755, 757, 759, 761, 763, 765, 
	767, 769, 771, 773, 775, 777, 779, 781, 
	783, 785, 787, 789, 792, 795, 799, 801, 
	803, 805, 807, 810, 812, 814, 816, 818, 
	820, 822, 824, 826, 828, 830, 832, 834, 
	836, 838, 840, 842, 844, 846, 848, 850, 
	852, 854, 856
};

static const char _lexer_trans_keys[] = {
	-17, 10, 32, 34, 35, 37, 42, 64, 
	67, 68, 69, 76, 77, 80, 124, 9, 
	13, -69, -65, 10, 32, 34, 35, 37, 
	42, 64, 67, 68, 69, 76, 77, 80, 
	124, 9, 13, 34, 34, 10, 13, 10, 
	13, 10, 32, 34, 9, 13, 10, 32, 
	34, 9, 13, 10, 32, 34, 9, 13, 
	10, 32, 34, 9, 13, 10, 32, 9, 
	13, 10, 32, 9, 13, 10, 13, 10, 
	95, 70, 69, 65, 84, 85, 82, 69, 
	95, 69, 78, 68, 95, 37, 32, 10, 
	13, 10, 13, 13, 32, 64, 9, 10, 
	9, 10, 13, 32, 64, 11, 12, 10, 
	32, 64, 9, 13, 97, 111, 110, 114, 
	100, 111, 97, 99, 116, 101, 114, -61, 
	-83, 115, 116, 105, 99, 97, 58, 10, 
	10, 10, 32, 35, 37, 64, 67, 69, 
	9, 13, 10, 95, 10, 70, 10, 69, 
	10, 65, 10, 84, 10, 85, 10, 82, 
	10, 69, 10, 95, 10, 69, 10, 78, 
	10, 68, 10, 95, 10, 37, 10, 97, 
	111, 10, 114, 10, 97, 10, 99, 10, 
	116, 10, 101, 10, 114, -61, 10, -83, 
	10, 10, 115, 10, 116, 10, 105, 10, 
	99, 10, 97, 10, 58, 10, 32, 34, 
	35, 37, 42, 64, 67, 68, 69, 76, 
	77, 80, 124, 9, 13, 97, 100, 97, 
	111, 32, 115, 32, 110, 115, 120, 116, 
	-61, -77, 110, 98, 99, 111, 122, 111, 
	32, 100, 111, 32, 101, 115, 99, 101, 
	110, 97, 114, 105, 111, 58, 10, 10, 
	10, 32, 35, 37, 42, 64, 67, 68, 
	69, 76, 77, 80, 9, 13, 10, 95, 
	10, 70, 10, 69, 10, 65, 10, 84, 
	10, 85, 10, 82, 10, 69, 10, 95, 
	10, 69, 10, 78, 10, 68, 10, 95, 
	10, 37, 10, 32, 10, 97, 10, 110, 
	114, 10, 100, 10, 111, 10, 97, 10, 
	99, 10, 116, 10, 101, 10, 114, -61, 
	10, -83, 10, 10, 115, 10, 116, 10, 
	105, 10, 99, 10, 97, 10, 58, 10, 
	97, 10, 100, 10, 97, 111, 10, 32, 
	115, 10, 32, 110, 115, 10, 116, -61, 
	10, -77, 10, 10, 110, 10, 99, 10, 
	101, 10, 110, 10, 97, 10, 114, 10, 
	105, 10, 111, 10, 111, 10, 103, 10, 
	97, 10, 105, 10, 115, 10, 101, 10, 
	114, 101, 110, 97, 114, 105, 111, 58, 
	10, 10, 10, 32, 35, 37, 42, 64, 
	67, 68, 69, 76, 77, 80, 9, 13, 
	10, 95, 10, 70, 10, 69, 10, 65, 
	10, 84, 10, 85, 10, 82, 10, 69, 
	10, 95, 10, 69, 10, 78, 10, 68, 
	10, 95, 10, 37, 10, 32, 10, 97, 
	111, 10, 110, 114, 10, 100, 10, 111, 
	10, 97, 10, 99, 10, 116, 10, 101, 
	10, 114, -61, 10, -83, 10, 10, 115, 
	10, 116, 10, 105, 10, 99, 10, 97, 
	10, 58, 10, 110, 10, 116, 10, 101, 
	10, 120, 10, 116, 10, 111, 10, 97, 
	10, 100, 10, 97, 111, 10, 32, 115, 
	10, 32, 110, 115, 10, 116, -61, 10, 
	-77, 10, 10, 110, 10, 98, 99, 10, 
	111, 10, 122, 10, 111, 10, 32, 10, 
	100, 10, 111, 10, 32, 10, 101, 10, 
	115, 10, 99, 10, 101, 10, 110, 10, 
	97, 10, 114, 10, 105, 10, 111, 10, 
	103, 10, 97, 10, 105, 10, 115, 10, 
	101, 10, 114, 101, 109, 112, 108, 111, 
	115, 58, 10, 10, 10, 32, 35, 67, 
	124, 9, 13, 10, 97, 10, 114, 10, 
	97, 10, 99, 10, 116, 10, 101, 10, 
	114, -61, 10, -83, 10, 10, 115, 10, 
	116, 10, 105, 10, 99, 10, 97, 10, 
	58, 111, 103, 97, 105, 115, 101, 114, 
	32, 124, 9, 13, 10, 32, 92, 124, 
	9, 13, 10, 92, 124, 10, 92, 10, 
	32, 92, 124, 9, 13, 10, 32, 34, 
	35, 37, 42, 64, 67, 68, 69, 76, 
	77, 80, 124, 9, 13, 10, 110, 10, 
	116, 10, 101, 10, 120, 10, 116, 10, 
	111, 10, 115, 120, 10, 98, 99, 10, 
	111, 10, 122, 10, 111, 10, 32, 10, 
	100, 10, 111, 10, 32, 10, 101, 10, 
	115, 10, 99, 10, 101, 10, 110, 10, 
	97, 10, 114, 10, 105, 10, 101, 10, 
	109, 10, 112, 10, 108, 10, 111, 10, 
	115, 110, 116, 101, 120, 116, 111, 58, 
	10, 10, 10, 32, 35, 37, 42, 64, 
	67, 68, 69, 76, 77, 80, 9, 13, 
	10, 95, 10, 70, 10, 69, 10, 65, 
	10, 84, 10, 85, 10, 82, 10, 69, 
	10, 95, 10, 69, 10, 78, 10, 68, 
	10, 95, 10, 37, 10, 32, 10, 97, 
	10, 110, 114, 10, 100, 10, 111, 10, 
	97, 10, 99, 10, 116, 10, 101, 10, 
	114, -61, 10, -83, 10, 10, 115, 10, 
	116, 10, 105, 10, 99, 10, 97, 10, 
	58, 10, 97, 10, 100, 10, 97, 111, 
	10, 32, 115, 10, 32, 110, 115, 10, 
	116, -61, 10, -77, 10, 10, 110, 10, 
	98, 99, 10, 111, 10, 122, 10, 111, 
	10, 32, 10, 100, 10, 111, 10, 32, 
	10, 101, 10, 115, 10, 99, 10, 101, 
	10, 110, 10, 97, 10, 114, 10, 105, 
	10, 111, 10, 111, 10, 103, 10, 97, 
	10, 105, 10, 115, 10, 101, 10, 114, 
	0
};

static const char _lexer_single_lengths[] = {
	0, 15, 1, 1, 14, 1, 1, 2, 
	2, 3, 3, 3, 3, 2, 2, 2, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	2, 2, 3, 5, 3, 2, 2, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	7, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 3, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 14, 1, 
	1, 2, 2, 4, 1, 1, 1, 1, 
	2, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 12, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 3, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 3, 
	3, 4, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 12, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 3, 3, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 3, 3, 
	4, 2, 2, 2, 2, 3, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 5, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 1, 1, 1, 
	1, 1, 1, 1, 2, 4, 3, 2, 
	4, 14, 2, 2, 2, 2, 2, 2, 
	3, 3, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	12, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 3, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 3, 3, 4, 2, 2, 
	2, 2, 3, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 0
};

static const char _lexer_range_lengths[] = {
	0, 1, 0, 0, 1, 0, 0, 0, 
	0, 1, 1, 1, 1, 1, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 1, 1, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 1, 0, 0, 
	1, 1, 0, 0, 0, 0, 0, 0, 
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
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0
};

static const short _lexer_index_offsets[] = {
	0, 0, 17, 19, 21, 37, 39, 41, 
	44, 47, 52, 57, 62, 67, 71, 75, 
	78, 80, 82, 84, 86, 88, 90, 92, 
	94, 96, 98, 100, 102, 104, 106, 108, 
	110, 113, 116, 121, 128, 133, 136, 139, 
	141, 143, 145, 147, 149, 151, 153, 155, 
	157, 159, 161, 163, 165, 167, 169, 171, 
	173, 182, 185, 188, 191, 194, 197, 200, 
	203, 206, 209, 212, 215, 218, 221, 224, 
	228, 231, 234, 237, 240, 243, 246, 249, 
	252, 255, 258, 261, 264, 267, 270, 286, 
	288, 290, 293, 296, 301, 303, 305, 307, 
	309, 312, 314, 316, 318, 320, 322, 324, 
	326, 328, 330, 332, 334, 336, 338, 340, 
	342, 344, 346, 348, 350, 364, 367, 370, 
	373, 376, 379, 382, 385, 388, 391, 394, 
	397, 400, 403, 406, 409, 412, 416, 419, 
	422, 425, 428, 431, 434, 437, 440, 443, 
	446, 449, 452, 455, 458, 461, 464, 467, 
	471, 475, 480, 483, 486, 489, 492, 495, 
	498, 501, 504, 507, 510, 513, 516, 519, 
	522, 525, 528, 531, 534, 536, 538, 540, 
	542, 544, 546, 548, 550, 552, 566, 569, 
	572, 575, 578, 581, 584, 587, 590, 593, 
	596, 599, 602, 605, 608, 611, 615, 619, 
	622, 625, 628, 631, 634, 637, 640, 643, 
	646, 649, 652, 655, 658, 661, 664, 667, 
	670, 673, 676, 679, 682, 685, 688, 692, 
	696, 701, 704, 707, 710, 713, 717, 720, 
	723, 726, 729, 732, 735, 738, 741, 744, 
	747, 750, 753, 756, 759, 762, 765, 768, 
	771, 774, 777, 780, 783, 785, 787, 789, 
	791, 793, 795, 797, 799, 801, 808, 811, 
	814, 817, 820, 823, 826, 829, 832, 835, 
	838, 841, 844, 847, 850, 853, 855, 857, 
	859, 861, 863, 865, 867, 871, 877, 881, 
	884, 890, 906, 909, 912, 915, 918, 921, 
	924, 928, 932, 935, 938, 941, 944, 947, 
	950, 953, 956, 959, 962, 965, 968, 971, 
	974, 977, 980, 983, 986, 989, 992, 995, 
	997, 999, 1001, 1003, 1005, 1007, 1009, 1011, 
	1013, 1027, 1030, 1033, 1036, 1039, 1042, 1045, 
	1048, 1051, 1054, 1057, 1060, 1063, 1066, 1069, 
	1072, 1075, 1079, 1082, 1085, 1088, 1091, 1094, 
	1097, 1100, 1103, 1106, 1109, 1112, 1115, 1118, 
	1121, 1124, 1127, 1130, 1134, 1138, 1143, 1146, 
	1149, 1152, 1155, 1159, 1162, 1165, 1168, 1171, 
	1174, 1177, 1180, 1183, 1186, 1189, 1192, 1195, 
	1198, 1201, 1204, 1207, 1210, 1213, 1216, 1219, 
	1222, 1225, 1228
};

static const short _lexer_trans_targs[] = {
	2, 4, 4, 5, 15, 17, 31, 34, 
	37, 87, 91, 277, 279, 282, 284, 4, 
	0, 3, 0, 4, 0, 4, 4, 5, 
	15, 17, 31, 34, 37, 87, 91, 277, 
	279, 282, 284, 4, 0, 6, 0, 7, 
	0, 9, 8, 8, 9, 8, 8, 10, 
	10, 11, 10, 10, 10, 10, 11, 10, 
	10, 10, 10, 12, 10, 10, 10, 10, 
	13, 10, 10, 4, 14, 14, 0, 4, 
	14, 14, 0, 4, 16, 15, 4, 0, 
	18, 0, 19, 0, 20, 0, 21, 0, 
	22, 0, 23, 0, 24, 0, 25, 0, 
	26, 0, 27, 0, 28, 0, 29, 0, 
	30, 0, 394, 0, 32, 0, 4, 16, 
	33, 4, 16, 33, 0, 0, 0, 0, 
	35, 36, 4, 36, 36, 34, 35, 35, 
	4, 36, 34, 36, 0, 38, 319, 0, 
	39, 41, 0, 40, 0, 31, 0, 42, 
	0, 43, 0, 44, 0, 45, 0, 46, 
	0, 47, 0, 48, 0, 49, 0, 50, 
	0, 51, 0, 52, 0, 53, 0, 54, 
	0, 56, 55, 56, 55, 56, 56, 4, 
	57, 4, 71, 296, 56, 55, 56, 58, 
	55, 56, 59, 55, 56, 60, 55, 56, 
	61, 55, 56, 62, 55, 56, 63, 55, 
	56, 64, 55, 56, 65, 55, 56, 66, 
	55, 56, 67, 55, 56, 68, 55, 56, 
	69, 55, 56, 70, 55, 56, 4, 55, 
	56, 72, 290, 55, 56, 73, 55, 56, 
	74, 55, 56, 75, 55, 56, 76, 55, 
	56, 77, 55, 56, 78, 55, 79, 56, 
	55, 80, 56, 55, 56, 81, 55, 56, 
	82, 55, 56, 83, 55, 56, 84, 55, 
	56, 85, 55, 56, 86, 55, 4, 4, 
	5, 15, 17, 31, 34, 37, 87, 91, 
	277, 279, 282, 284, 4, 0, 88, 0, 
	89, 0, 90, 90, 0, 32, 31, 0, 
	32, 92, 96, 252, 0, 93, 0, 94, 
	0, 95, 0, 31, 0, 97, 172, 0, 
	98, 0, 99, 0, 100, 0, 101, 0, 
	102, 0, 103, 0, 104, 0, 105, 0, 
	106, 0, 107, 0, 108, 0, 109, 0, 
	110, 0, 111, 0, 112, 0, 113, 0, 
	114, 0, 116, 115, 116, 115, 116, 116, 
	4, 117, 131, 4, 132, 149, 153, 165, 
	167, 170, 116, 115, 116, 118, 115, 116, 
	119, 115, 116, 120, 115, 116, 121, 115, 
	116, 122, 115, 116, 123, 115, 116, 124, 
	115, 116, 125, 115, 116, 126, 115, 116, 
	127, 115, 116, 128, 115, 116, 129, 115, 
	116, 130, 115, 116, 4, 115, 116, 86, 
	115, 116, 133, 115, 116, 134, 136, 115, 
	116, 135, 115, 116, 131, 115, 116, 137, 
	115, 116, 138, 115, 116, 139, 115, 116, 
	140, 115, 116, 141, 115, 142, 116, 115, 
	143, 116, 115, 116, 144, 115, 116, 145, 
	115, 116, 146, 115, 116, 147, 115, 116, 
	148, 115, 116, 86, 115, 116, 150, 115, 
	116, 151, 115, 116, 152, 152, 115, 116, 
	86, 131, 115, 116, 86, 154, 158, 115, 
	116, 155, 115, 156, 116, 115, 157, 116, 
	115, 116, 131, 115, 116, 159, 115, 116, 
	160, 115, 116, 161, 115, 116, 162, 115, 
	116, 163, 115, 116, 164, 115, 116, 148, 
	115, 116, 166, 115, 116, 135, 115, 116, 
	168, 115, 116, 169, 115, 116, 131, 115, 
	116, 171, 115, 116, 135, 115, 173, 0, 
	174, 0, 175, 0, 176, 0, 177, 0, 
	178, 0, 179, 0, 181, 180, 181, 180, 
	181, 181, 4, 182, 196, 4, 197, 220, 
	224, 245, 247, 250, 181, 180, 181, 183, 
	180, 181, 184, 180, 181, 185, 180, 181, 
	186, 180, 181, 187, 180, 181, 188, 180, 
	181, 189, 180, 181, 190, 180, 181, 191, 
	180, 181, 192, 180, 181, 193, 180, 181, 
	194, 180, 181, 195, 180, 181, 4, 180, 
	181, 86, 180, 181, 198, 214, 180, 181, 
	199, 201, 180, 181, 200, 180, 181, 196, 
	180, 181, 202, 180, 181, 203, 180, 181, 
	204, 180, 181, 205, 180, 181, 206, 180, 
	207, 181, 180, 208, 181, 180, 181, 209, 
	180, 181, 210, 180, 181, 211, 180, 181, 
	212, 180, 181, 213, 180, 181, 86, 180, 
	181, 215, 180, 181, 216, 180, 181, 217, 
	180, 181, 218, 180, 181, 219, 180, 181, 
	213, 180, 181, 221, 180, 181, 222, 180, 
	181, 223, 223, 180, 181, 86, 196, 180, 
	181, 86, 225, 229, 180, 181, 226, 180, 
	227, 181, 180, 228, 181, 180, 181, 196, 
	180, 181, 230, 240, 180, 181, 231, 180, 
	181, 232, 180, 181, 233, 180, 181, 234, 
	180, 181, 235, 180, 181, 236, 180, 181, 
	237, 180, 181, 238, 180, 181, 239, 180, 
	181, 240, 180, 181, 241, 180, 181, 242, 
	180, 181, 243, 180, 181, 244, 180, 181, 
	219, 180, 181, 246, 180, 181, 200, 180, 
	181, 248, 180, 181, 249, 180, 181, 196, 
	180, 181, 251, 180, 181, 200, 180, 253, 
	0, 254, 0, 255, 0, 256, 0, 257, 
	0, 258, 0, 259, 0, 261, 260, 261, 
	260, 261, 261, 4, 262, 4, 261, 260, 
	261, 263, 260, 261, 264, 260, 261, 265, 
	260, 261, 266, 260, 261, 267, 260, 261, 
	268, 260, 261, 269, 260, 270, 261, 260, 
	271, 261, 260, 261, 272, 260, 261, 273, 
	260, 261, 274, 260, 261, 275, 260, 261, 
	276, 260, 261, 86, 260, 278, 0, 40, 
	0, 280, 0, 281, 0, 31, 0, 283, 
	0, 40, 0, 284, 285, 284, 0, 289, 
	288, 287, 285, 288, 286, 0, 287, 285, 
	286, 0, 287, 286, 289, 288, 287, 285, 
	288, 286, 289, 289, 5, 15, 17, 31, 
	34, 37, 87, 91, 277, 279, 282, 284, 
	289, 0, 56, 291, 55, 56, 292, 55, 
	56, 293, 55, 56, 294, 55, 56, 295, 
	55, 56, 85, 55, 56, 297, 313, 55, 
	56, 298, 308, 55, 56, 299, 55, 56, 
	300, 55, 56, 301, 55, 56, 302, 55, 
	56, 303, 55, 56, 304, 55, 56, 305, 
	55, 56, 306, 55, 56, 307, 55, 56, 
	308, 55, 56, 309, 55, 56, 310, 55, 
	56, 311, 55, 56, 312, 55, 56, 295, 
	55, 56, 314, 55, 56, 315, 55, 56, 
	316, 55, 56, 317, 55, 56, 318, 55, 
	56, 85, 55, 320, 0, 321, 0, 322, 
	0, 323, 0, 324, 0, 325, 0, 326, 
	0, 328, 327, 328, 327, 328, 328, 4, 
	329, 343, 4, 344, 361, 365, 387, 389, 
	392, 328, 327, 328, 330, 327, 328, 331, 
	327, 328, 332, 327, 328, 333, 327, 328, 
	334, 327, 328, 335, 327, 328, 336, 327, 
	328, 337, 327, 328, 338, 327, 328, 339, 
	327, 328, 340, 327, 328, 341, 327, 328, 
	342, 327, 328, 4, 327, 328, 86, 327, 
	328, 345, 327, 328, 346, 348, 327, 328, 
	347, 327, 328, 343, 327, 328, 349, 327, 
	328, 350, 327, 328, 351, 327, 328, 352, 
	327, 328, 353, 327, 354, 328, 327, 355, 
	328, 327, 328, 356, 327, 328, 357, 327, 
	328, 358, 327, 328, 359, 327, 328, 360, 
	327, 328, 86, 327, 328, 362, 327, 328, 
	363, 327, 328, 364, 364, 327, 328, 86, 
	343, 327, 328, 86, 366, 370, 327, 328, 
	367, 327, 368, 328, 327, 369, 328, 327, 
	328, 343, 327, 328, 371, 381, 327, 328, 
	372, 327, 328, 373, 327, 328, 374, 327, 
	328, 375, 327, 328, 376, 327, 328, 377, 
	327, 328, 378, 327, 328, 379, 327, 328, 
	380, 327, 328, 381, 327, 328, 382, 327, 
	328, 383, 327, 328, 384, 327, 328, 385, 
	327, 328, 386, 327, 328, 360, 327, 328, 
	388, 327, 328, 347, 327, 328, 390, 327, 
	328, 391, 327, 328, 343, 327, 328, 393, 
	327, 328, 347, 327, 0, 0
};

static const unsigned char _lexer_trans_actions[] = {
	0, 54, 0, 5, 1, 0, 29, 1, 
	29, 29, 29, 29, 29, 29, 35, 0, 
	43, 0, 43, 0, 43, 54, 0, 5, 
	1, 0, 29, 1, 29, 29, 29, 29, 
	29, 29, 35, 0, 43, 0, 43, 0, 
	43, 139, 48, 9, 106, 11, 0, 134, 
	45, 45, 45, 3, 122, 33, 33, 33, 
	0, 122, 33, 33, 33, 0, 122, 33, 
	0, 33, 0, 102, 7, 7, 43, 54, 
	0, 0, 43, 114, 25, 0, 54, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 149, 126, 
	57, 110, 23, 0, 43, 43, 43, 43, 
	0, 27, 118, 27, 27, 51, 27, 0, 
	54, 0, 1, 0, 43, 0, 0, 43, 
	0, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 144, 57, 54, 0, 54, 0, 69, 
	33, 69, 84, 84, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 13, 0, 
	54, 0, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 0, 54, 
	0, 0, 54, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 13, 0, 130, 31, 
	60, 57, 31, 63, 57, 63, 63, 63, 
	63, 63, 63, 66, 31, 43, 0, 43, 
	0, 43, 0, 0, 43, 0, 0, 43, 
	0, 0, 0, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 144, 57, 54, 0, 54, 0, 
	78, 33, 84, 78, 84, 84, 84, 84, 
	84, 84, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 19, 0, 54, 19, 
	0, 54, 0, 0, 54, 0, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 0, 54, 0, 
	0, 54, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 19, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 0, 54, 
	19, 0, 0, 54, 19, 0, 0, 0, 
	54, 0, 0, 0, 54, 0, 0, 54, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 0, 43, 
	0, 43, 0, 43, 0, 43, 0, 43, 
	0, 43, 0, 43, 144, 57, 54, 0, 
	54, 0, 75, 33, 84, 75, 84, 84, 
	84, 84, 84, 84, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 17, 0, 
	54, 17, 0, 54, 0, 0, 0, 54, 
	0, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	0, 54, 0, 0, 54, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 17, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 0, 54, 17, 0, 0, 
	54, 17, 0, 0, 0, 54, 0, 0, 
	0, 54, 0, 0, 54, 0, 54, 0, 
	0, 54, 0, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 144, 57, 54, 
	0, 54, 0, 81, 84, 81, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 0, 54, 0, 
	0, 54, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 21, 0, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 0, 0, 43, 54, 
	37, 37, 87, 37, 37, 43, 0, 39, 
	0, 43, 0, 0, 54, 0, 0, 39, 
	0, 0, 54, 0, 93, 90, 41, 96, 
	90, 96, 96, 96, 96, 96, 96, 99, 
	0, 43, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 0, 
	54, 0, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 0, 43, 0, 43, 0, 
	43, 0, 43, 0, 43, 0, 43, 0, 
	43, 144, 57, 54, 0, 54, 0, 72, 
	33, 84, 72, 84, 84, 84, 84, 84, 
	84, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 15, 0, 54, 15, 0, 
	54, 0, 0, 54, 0, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 0, 54, 0, 0, 
	54, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 15, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 0, 54, 15, 
	0, 0, 54, 15, 0, 0, 0, 54, 
	0, 0, 0, 54, 0, 0, 54, 0, 
	54, 0, 0, 54, 0, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 54, 0, 0, 54, 
	0, 0, 54, 0, 0, 54, 0, 0, 
	54, 0, 0, 54, 0, 0, 54, 0, 
	0, 54, 0, 0, 0, 0
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
	43, 43, 43
};

static const int lexer_start = 1;
static const int lexer_first_final = 394;
static const int lexer_error = 0;

static const int lexer_en_main = 1;


#line 258 "ragel/i18n/gl.c.rl"

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
    
    
#line 978 "ext/gherkin_lexer_gl/gherkin_lexer_gl.c"
	{
	cs = lexer_start;
	}

#line 425 "ragel/i18n/gl.c.rl"
    
#line 985 "ext/gherkin_lexer_gl/gherkin_lexer_gl.c"
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
#line 83 "ragel/i18n/gl.c.rl"
	{
		MARK(content_start, p);
    lexer->current_line = lexer->line_number;
    lexer->start_col = lexer->content_start - lexer->last_newline - (lexer->keyword_end - lexer->keyword_start) + 2;
  }
	break;
	case 1:
#line 89 "ragel/i18n/gl.c.rl"
	{
    MARK(content_start, p);
  }
	break;
	case 2:
#line 93 "ragel/i18n/gl.c.rl"
	{
    lexer->current_line = lexer->line_number;
    lexer->start_col = p - data - lexer->last_newline;
  }
	break;
	case 3:
#line 98 "ragel/i18n/gl.c.rl"
	{
    int len = LEN(content_start, PTR_TO(final_newline));
    int type_len = LEN(docstring_content_type_start, PTR_TO(docstring_content_type_end));

    if (len < 0) len = 0;
    if (type_len < 0) len = 0;

    store_docstring_content(listener, lexer->start_col, PTR_TO(docstring_content_type_start), type_len, PTR_TO(content_start), len, lexer->current_line);
  }
	break;
	case 4:
#line 108 "ragel/i18n/gl.c.rl"
	{ 
    MARK(docstring_content_type_start, p);
  }
	break;
	case 5:
#line 112 "ragel/i18n/gl.c.rl"
	{ 
    MARK(docstring_content_type_end, p);
  }
	break;
	case 6:
#line 116 "ragel/i18n/gl.c.rl"
	{
    STORE_KW_END_CON(feature);
  }
	break;
	case 7:
#line 120 "ragel/i18n/gl.c.rl"
	{
    STORE_KW_END_CON(background);
  }
	break;
	case 8:
#line 124 "ragel/i18n/gl.c.rl"
	{
    STORE_KW_END_CON(scenario);
  }
	break;
	case 9:
#line 128 "ragel/i18n/gl.c.rl"
	{
    STORE_KW_END_CON(scenario_outline);
  }
	break;
	case 10:
#line 132 "ragel/i18n/gl.c.rl"
	{
    STORE_KW_END_CON(examples);
  }
	break;
	case 11:
#line 136 "ragel/i18n/gl.c.rl"
	{
    store_kw_con(listener, "step",
      PTR_TO(keyword_start), LEN(keyword_start, PTR_TO(keyword_end)),
      PTR_TO(content_start), LEN(content_start, p), 
      lexer->current_line);
  }
	break;
	case 12:
#line 143 "ragel/i18n/gl.c.rl"
	{
    STORE_ATTR(comment);
    lexer->mark = 0;
  }
	break;
	case 13:
#line 148 "ragel/i18n/gl.c.rl"
	{
    STORE_ATTR(tag);
    lexer->mark = 0;
  }
	break;
	case 14:
#line 153 "ragel/i18n/gl.c.rl"
	{
    lexer->line_number += 1;
    MARK(final_newline, p);
  }
	break;
	case 15:
#line 158 "ragel/i18n/gl.c.rl"
	{
    MARK(last_newline, p + 1);
  }
	break;
	case 16:
#line 162 "ragel/i18n/gl.c.rl"
	{
    if (lexer->mark == 0) {
      MARK(mark, p);
    }
  }
	break;
	case 17:
#line 168 "ragel/i18n/gl.c.rl"
	{
    MARK(keyword_end, p);
    MARK(keyword_start, PTR_TO(mark));
    MARK(content_start, p + 1);
    lexer->mark = 0;
  }
	break;
	case 18:
#line 175 "ragel/i18n/gl.c.rl"
	{
    MARK(content_end, p);
  }
	break;
	case 19:
#line 179 "ragel/i18n/gl.c.rl"
	{
    p = p - 1;
    lexer->current_line = lexer->line_number;
    current_row = rb_ary_new();
  }
	break;
	case 20:
#line 185 "ragel/i18n/gl.c.rl"
	{
		MARK(content_start, p);
  }
	break;
	case 21:
#line 189 "ragel/i18n/gl.c.rl"
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
#line 203 "ragel/i18n/gl.c.rl"
	{
    rb_funcall(listener, rb_intern("row"), 2, current_row, INT2FIX(lexer->current_line));
  }
	break;
	case 23:
#line 207 "ragel/i18n/gl.c.rl"
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
#line 1275 "ext/gherkin_lexer_gl/gherkin_lexer_gl.c"
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
#line 207 "ragel/i18n/gl.c.rl"
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
#line 1338 "ext/gherkin_lexer_gl/gherkin_lexer_gl.c"
		}
	}
	}

	_out: {}
	}

#line 426 "ragel/i18n/gl.c.rl"

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

void Init_gherkin_lexer_gl()
{
  mGherkin = rb_define_module("Gherkin");
  mGherkinLexer = rb_define_module_under(mGherkin, "Lexer");
  rb_eGherkinLexingError = rb_const_get(mGherkinLexer, rb_intern("LexingError"));

  mCLexer = rb_define_module_under(mGherkin, "CLexer");
  cI18nLexer = rb_define_class_under(mCLexer, "Gl", rb_cObject);
  rb_define_alloc_func(cI18nLexer, CLexer_alloc);
  rb_define_method(cI18nLexer, "initialize", CLexer_init, 1);
  rb_define_method(cI18nLexer, "scan", CLexer_scan, 1);
}

